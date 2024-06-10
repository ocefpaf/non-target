"""Test against known results."""

from pathlib import Path

import pandas as pd
import pytest

from susp_screen import check_suspect

root_path = Path(__file__).parent


@pytest.fixture()
def load_data():
    """Load data for comparison."""
    RD = pd.read_csv(root_path.joinpath("SuspectInput-Realdry.csv"))
    new_cols = {
        "m/z": "MZ",
        "CCS (angstrom^2)": "CCS",
        "Retention time (min)": "RT",
    }
    RD = RD.rename(mapper=new_cols, axis="columns")

    lib_ref = pd.read_csv("AMAPECHA.csv")
    new_cols = {
        "M+.": "MZ",
        "[M+H]+": "MZp",  # This one should be used in the wet condition
        "CCS (Å2)": "CCS",
        "Retention time (min)": "RT",
    }
    lib_ref = lib_ref.rename(mapper=new_cols, axis="columns")

    res = pd.read_csv(
        root_path.joinpath("SuspectOutput-dryECHA.csv"),
        low_memory=False,
    ).set_index("Entry")
    new_cols = {
        "m.z": "MZ",
        "CCS..angstrom.2.": "CCS",
        "Retention.time..min.": "RT",
    }
    res = res.rename(mapper=new_cols, axis="columns")
    return (RD, lib_ref, res)


def test_check_suspect(load_data):
    """Check against a known output file."""
    RD, lib_ref, res = load_data
    for _, row in RD.iterrows():
        entry = row["Entry"]

        rd = RD.loc[RD["Entry"] == entry].squeeze()
        ret = check_suspect(lib_ref=lib_ref, rd=rd)

        ours = ret.to_numpy()[:, 1:].ravel()
        expected = res.loc[entry].dropna().to_numpy()[3:]

        assert all(ours == expected)
