import os
import re
import shutil

def parse_version(name):
    m = re.match(r'^(\d+)\.(\d+)\.(\d+)(?:\.(\d+))?$', name)
    if not m:
        return None
    d, mo, y = int(m.group(1)), int(m.group(2)), int(m.group(3))
    p = int(m.group(4)) if m.group(4) is not None else 0
    return (y, mo, d, p)

def main():
    print("=== Update Folder Cleanup ===\n")

    cutoff_input = input("Delete all folders prior to (format dd.mm.yy[.patch]): ").strip()
    cutoff = parse_version(cutoff_input)
    if not cutoff:
        print("Invalid format. Please use dd.mm.yy or dd.mm.yy.patch (e.g. 12.12.25 or 12.12.25.1)")
        return

    cwd = os.getcwd()
    folders = [f for f in os.listdir(cwd) if os.path.isdir(f) and parse_version(f)]
    to_delete = [f for f in folders if parse_version(f) < cutoff]
    to_delete.sort(key=parse_version)

    if not to_delete:
        print("\nNo folders to delete.")
        return

    print(f"\nFolders to delete ({len(to_delete)}):")
    for f in to_delete:
        print(f"  - {f}")

    confirm = input(f"\nDelete these {len(to_delete)} folder(s)? (yes/no): ").strip().lower()
    if confirm == "yes":
        for f in to_delete:
            try:
                shutil.rmtree(f)
                print(f"  Deleted: {f}")
            except Exception as e:
                print(f"  Error deleting {f}: {e}")
        print("\nDone.")
    else:
        print("Aborted. Nothing was deleted.")

if __name__ == "__main__":
    main()