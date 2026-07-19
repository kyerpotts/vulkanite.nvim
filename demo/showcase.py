from __future__ import annotations

from dataclasses import dataclass
from functools import cached_property
from pathlib import Path
from typing import Iterable

DEFAULT_PATTERN = r"^#[0-9a-fA-F]{6}$"


@dataclass(frozen=True, slots=True)
class PaletteEntry:
    name: str
    value: str

    @cached_property
    def label(self) -> str:
        return f"{self.name}: {self.value.upper()}"


def load_palette(paths: Iterable[Path]) -> dict[str, PaletteEntry]:
    """Build a palette index from existing files."""
    entries = {
        path.stem: PaletteEntry(path.stem, path.read_text().strip())
        for path in paths
        if path.exists()
    }
    if not entries:
        raise ValueError("palette is empty")
    return entries


if __name__ == "__main__":
    palette = load_palette(Path("colors").glob("*.hex"))
    print(*(entry.label for entry in palette.values()), sep="\n")
