# Lebenslauf / Curriculum Vitae

This project includes my latest (maybe outdated) CV and cover letter template I use, supported in both English and German. 

## Project structure

```
.
├── .gitignore
├── DE  # German
│   ├── bewerbungsschreiben.pdf
│   ├── bewerbungsschreiben.tex     # German cover letter (template, as it should be unique per submission)
│   ├── lebenslauf.pdf
│   └── lebenslauf.tex              # German CV
├── EN  # English
│   ├── cover_letter.pdf
│   ├── cover_letter.tex            # English cover letter (template)
│   ├── curriculum_vitae.pdf
│   └── curriculum_vitae.tex        # English CV
├── cv.cls                          # class file for formatting
└── latexmkrc                       # LaTeX make config file
```

## How to use

```bash
git clone https://github.com/prosk-sudo/CV.git

cd CV; rm -rf .git;     # You definitely do not want my CV :D

# Now you modify the LaTeX files to your taste like adding sections, 
# changing names, before running the next commands.

# You should run these from the repo root!
latexmk                 # Compile every .tex file in EN/ and DE/
latexmk -c              # Clean up files
```

## Prerequisites

A TeX distribution that ships `pdflatex` and `latexmk`:

- **macOS**: [MacTeX](https://www.tug.org/mactex/)
- **Linux**: TeX Live (`texlive-full`, or at least a selection that includes
  `fontawesome5`, `paracol`, and friends)

## Writing a cover letter

Unlike the CVs, the letters in `EN/` and `DE/` are templates: everything application-specific is marked with gray bracketed placeholders (`\placeholder{...}` in English, `\platzhalter{...}` in German - both defined in `cv.cls`).

For an actual application, copy the template and fill in the brackets:

```bash
cp EN/cover_letter.tex EN/cover_letter_google.tex
```

Files named `cover_letter_*` / `bewerbungsschreiben_*` are gitignored, so company-specific letters never end up in the repo.

### Signature

The `[Signature]` placeholder has a commented-out `\includegraphics` line right
above it. Put a scanned signature at the path that line expects (the whole
`images/` directory is gitignored), then swap the placeholder for the
uncommented line.
