"""Peak matching."""

import numpy as np
import pandas as pd


def _if_rt(lib: pd.Series, rd: pd.Series, vals: dict) -> dict:
    if lib["RT"] - 0.5 < rd["RT"] < lib["RT"] + 0.5:
        d = 1
    else:
        d = np.abs(rd["RT"] - lib["RT"])
        d = np.round((d - 0.5) / 0.5, 2)
    vals.update({"RT": lib["RT"], "RTs": d})
    return vals


def _if_ccs(lib: pd.Series, rd: pd.Series, vals: dict) -> dict:
    if lib["Sourceb"] == "Measured":
        if lib["CCS"] * 0.98 < rd["CCS"] < lib["CCS"] * 1.02:
            d = 1
        elif lib["CCS"] * 0.97 < rd["CCS"] < lib["CCS"] * 1.03:
            d = (np.abs(rd["CCS"] - lib["CCS"])) / lib["CCS"]
            d = np.round((d - 0.02) / 0.01, 2)
        else:
            d = 0
    elif lib["CCS"] * 0.95 < rd["CCS"] < lib["CCS"] * 1.05:
        d = 1
    else:
        d = (np.abs(rd["CCS"] - lib["CCS"])) / lib["CCS"]
        d = np.round((d - 0.05) / 0.02, 2)
    vals.update({"CCS": lib["CCS"], "CCSs": d})
    return vals


def _stage(lib: pd.Series, rd: pd.Series, stage: int) -> bool:
    if stage == 1:
        check = lib["MZ"] - 0.002 < rd["MZ"] < lib["MZ"] + 0.002
    elif stage == 2:
        check = lib["MZ"] * 0.999995 < rd["MZ"] < lib["MZ"] * 1.000005
    else:
        msg = f"Expected stage 1 or 2, got {stage}."
        raise ValueError(msg)

    return (
        check
        and lib["CCS"] * 0.93 < rd["CCS"] < lib["CCS"] * 1.07
        and lib["RT"] - 1 < rd["RT"] < lib["RT"] + 1
    )


def check_suspect(lib_ref: pd.DataFrame, rd: pd.Series) -> pd.DataFrame:
    """Check if a detected peak has a match in a defined database given some
    pre-defined parameters.

    Returns a DataFrame with peak entry number, match identity, and score.

    """
    ret = []
    for _, lib in lib_ref.iterrows():
        #  Short-circuit that skips all checks.
        # NOTE: This comparison is not documented in the PPT.
        if lib["MZ"] > (rd["MZ"] + 0.002):
            continue

        vals = {}
        mz_200 = 200
        if (
            rd["MZ"] < mz_200
            and _stage(lib=lib, rd=rd, stage=1)
            or rd["MZ"] > mz_200
            and _stage(lib=lib, rd=rd, stage=2)
        ):
            vals.update(
                {
                    "Entry": rd["Entry"],
                    "Identity": lib["Identity"],
                    "MZ": lib["MZ"],
                },
            )
            vals = _if_rt(lib, rd, vals)  # RT
            vals = _if_ccs(lib, rd, vals)  # CCS
            ret.append(vals)
    return pd.DataFrame(ret)
