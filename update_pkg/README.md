<h1 align="center">DNF System Update</h1>
<p align="center">
  <b>Shell script to update a APT or DNF managed system</b>
</p>

<BR>

---

The script updates the system, removes unneeded packages, and clears the package manager cache. It also creates some simple aliases for easy script launching and system navigation.

The first run saves a copy of the script in the user's home directory, `$HOME/scripts/prod`, and attempts to create aliases in the `.bash_aliases` file if it does not exist, which it then sources. At the end, the script removes itself from the starting directory.

---

<BR>

## DOWNLOAD

- For **APT**
  > [▶️ update_apt.sh](./update_apt.sh)

- For **DNF**
  > [▶️ update_dnf.sh](./update_dnf.sh)

<BR>

## SYNTAX

- **APT**
  - Alias: `updateapt`
  
```bash
$ ~/update_apt.sh
```

- **DNF**
  - Alias: `updatednf`

```bash
$ ~/update_dnf.sh
```

> Alias is only available after the first execution.

<BR>

## REQUIREMENTS

- The system must be managed by **APT** or **DNF**.

<BR>

## UTILIZATION

**1.** Download the script and save it on your system.

**2.** Give the script execution permission.

**3.** Run the script.

<BR>

## EXAMPLE
```
$ updatednf

    COMPLETE SYSTEM UPDATE
     USER ALIAS CREATION


********* ATENTION ***********
*THIS SCRIPT WILL UPDATE YOUR*
*     SYSTEM COMPLETELY.     *
*  IT MIGHT TAKE SOME TIME   *
******************************
DO YOU WISH TO CONTINUE? <y/n> >>
```