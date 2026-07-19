import { useMemo, type ReactNode } from "react";

interface PaletteEntry {
  readonly name: string;
  hex: `#${string}`;
}

type SwatchProps<T extends PaletteEntry> = {
  entries: T[];
  renderLabel?: (entry: T) => ReactNode;
};

/**
 * @template T extends PaletteEntry - [TODO:type]
 * @param [TODO:description] - [TODO:description]
 * @returns [TODO:return]
 */
export function Swatches<T extends PaletteEntry>({
  entries,
  renderLabel = (entry) => entry.name,
}: SwatchProps<T>) {
  const visible = useMemo(
    () => entries.filter(({ name }) => !name.startsWith("internal_")),
    [entries],
  );

  return (
    <section aria-label="Vulkanite palette">
      {visible.map((entry) => (
        <article key={entry.name} style={{ borderColor: entry.hex }}>
          <strong>{renderLabel(entry)}</strong>
          <code>{entry.hex}</code>
        </article>
      ))}
    </section>
  );
}
