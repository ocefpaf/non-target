"""Peak matching."""

import numpy as np
import pandas as pd


def _if_rt(lib: pd.Series, rd: pd.Series, vals: dict) -> dict:
    if lib["RT"] - 0.5 < rd["RT"] < lib["RT"] + 0.5:
        vals.update({"RT": lib["RT"], "RTs": 1})
    else:
        d = np.abs(rd["RT"] - lib["RT"])
        d = np.round((d - 0.5) / 0.5, 2)
        vals.update({"RT": lib["RT"], "RTs": d})
    return vals


def _if_ccs(lib: pd.Series, rd: pd.Series, vals: dict) -> dict:
    if lib["Sourceb"] == "Measured":
        if lib["CCS"] * 0.98 < rd["CCS"] < lib["CCS"] * 1.02:
            vals.update({"CCS": lib["CCS"], "CCSs": 1})
        elif lib["CCS"] * 0.97 < rd["CCS"] < lib["CCS"] * 1.03:
            d = (np.abs(rd["CCS"] - lib["CCS"])) / lib["CCS"]
            d = np.round((d - 0.02) / 0.01, 2)
            vals.update({"CCS": lib["CCS"], "CCSs": d})
        else:
            vals.update({"CCS": lib["CCS"], "CCSs": 0})
    elif lib["CCS"] * 0.95 < rd["CCS"] < lib["CCS"] * 1.05:
        vals.update({"CCS": lib["CCS"], "CCSs": 1})
    else:
        d = (np.abs(rd["CCS"] - lib["CCS"])) / lib["CCS"]
        d = np.round((d - 0.05) / 0.02, 2)
        vals.update({"CCS": lib["CCS"], "CCSs": d})
    return vals


def _stages(lib: pd.Series, rd: pd.Series, stage: int) -> bool:
    if stage == 1:
        stage = lib["MZ"] - 0.002 < rd["MZ"] < lib["MZ"] + 0.002
    elif stage == 2:
        stage = lib["MZ"] * 0.999995 < rd["MZ"] < lib["MZ"] * 1.000005
    else:
        msg = f"Expected stage 1 or 2, got {stage}."
        raise ValueError(msg)

    return (
        stage
        and lib["CCS"] * 0.93 < rd["CCS"] < lib["CCS"] * 1.07
        and lib["RT"] - 1 < rd["RT"] < lib["RT"] + 1
    )


def _check_suspect(lib_ref: pd.DataFrame, rd: pd.Series) -> pd.DataFrame:
    """Check if a detected peak has a match in a defined database."""
    ret = []
    for _, lib in lib_ref.iterrows():
        vals = {}
        #  Short-circuit that skips all checks.
        # NOTE: This comparison is not documented in the PPT.
        if lib["MZ"] > (rd["MZ"] + 0.002):
            continue

        mz_200 = 200
        if rd["MZ"] < mz_200:
            if _stages(lib=lib, rd=rd, stage=1):
                vals.update(
                    {
                        "Entry": rd["Entry"],
                        "Identity": lib["Identity"],
                        "MZ": lib["MZ"],
                    },
                )
                # RT
                vals = _if_rt(lib, rd, vals)
                # CCS
                vals = _if_ccs(lib, rd, vals)
                ret.append(vals)
        # mz >200
        elif _stages(lib=lib, rd=rd, stage=2):
            vals.update(
                {
                    "Entry": rd["Entry"],
                    "Identity": lib["Identity"],
                    "MZ": lib["MZ"],
                },
            )
            # RT
            vals = _if_rt(lib, rd, vals)
            # CCS
            vals = _if_ccs(lib, rd, vals)
            ret.append(vals)
    return pd.DataFrame(ret)


def check_suspect(lib_ref: pd.DataFrame, rd: pd.Series) -> pd.DataFrame:
    """Check if a detected peak has a match in a defined database."""
    ret = []
    for _, lib in lib_ref.iterrows():
        vals = {}
        #  Short-circuit that skips all checks.
        # NOTE: This comparison is not documented in the PPT.
        if lib["MZ"] > (rd["MZ"] + 0.002):
            continue

        mz_200 = 200
        if (
            rd["MZ"] < mz_200 and _stages(lib=lib, rd=rd, stage=1) or
            rd["MZ"] > mz_200 and _stages(lib=lib, rd=rd, stage=2)
        ):
            vals.update(
                {
                    "Entry": rd["Entry"],
                    "Identity": lib["Identity"],
                    "MZ": lib["MZ"],
                },
            )
            # RT
            vals = _if_rt(lib, rd, vals)
            # CCS
            vals = _if_ccs(lib, rd, vals)
            ret.append(vals)
    return pd.DataFrame(ret)


if __name__ == "__main__":
    # Load Input, Reference, and Expected results files.
    RD = pd.read_csv("SuspectInput-Realdry.csv")
    lib_ref = pd.read_csv("AMAPECHA.csv")
    res = pd.read_csv(
        "SuspectOutput-dryECHA.csv",
        low_memory=False,
        header=0,
    ).set_index("Entry")

    # Rename the columns for easier access and comparisons.
    new_cols = {
        "m.z": "MZ",
        "CCS..angstrom.2.": "CCS",
        "Retention.time..min.": "RT",
    }
    res = res.rename(mapper=new_cols, axis="columns")
    dense = res.loc[:, "V5":].dropna(
        how="all",
        axis=0,
    )  # Make the matrix a bit less sparse.

    new_cols = {
        "m/z": "MZ",
        "CCS (angstrom^2)": "CCS",
        "Retention time (min)": "RT",
    }
    RD = RD.rename(mapper=new_cols, axis="columns")

    new_cols = {
        "M+.": "MZ",
        "[M+H]+": "MZp",
        "CCS (Å2)": "CCS",
        "Retention time (min)": "RT",
    }
    lib_ref = lib_ref.rename(mapper=new_cols, axis="columns")

    # Run for all peaks in the Ipunt and save a CSV file.
    if False:
        dfs = []
        for _, rd in RD.iterrows():
            dfs.append(check_suspect(lib_ref=lib_ref, rd=rd))
        dfs = pd.concat(dfs)
        dfs.to_csv("results.csv")
    # For for each peak and test against a known output.
    if True:
        for _, row in RD.iterrows():
            entry = row["Entry"]

            rd = RD.loc[RD["Entry"] == entry].squeeze()
            ret = check_suspect(lib_ref=lib_ref, rd=rd)

            ours = ret.to_numpy()[:, 1:].ravel()
            expected = res.loc[entry].dropna().to_numpy()[3:]

            if not all(ours == expected):
                print(f"{ours=}")
                print(f"{expected=}")
            else:
                print(f"{entry=} passed.")
