all: check-dates spelling

## Assert that all dates are from 2024-11
check-dates: index.qmd
	## All YYYY years mentioned are from 2018, 2020, or this year
	! grep -E "\b202[[:digit:]]\b" "$<" | grep -q -v -E "(2018|2020|2024)"
	## All YYYY-MM-DD and MM/DD/YYYY dates are from 2024-11-04
	! grep -E "(\b202[[:digit:]]-|/202[[:digit:]])" "$<" | grep -v -E "\b(2024-11-04|11/04/2024)\b"

spelling: index.qmd
	Rscript -e 'spelling::spell_check_files("$<", ignore = readLines("WORDLIST"))'

install-extensions:
	quarto add quarto-ext/pointer
	quarto install extension EmilHvitfeldt/quarto-roughnotation

preview:
	quarto preview
