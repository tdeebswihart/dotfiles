export VIRTUAL_ENV_DISABLE_PROMPT=1

__conda_setup () {
    test -f "$1/etc/profile.d/conda.sh" && . "$1/etc/profile.d/conda.sh"
}

for pfx in $(iter "$HOME" "/usr/local"); do
  for variant in $(iter "miniconda" "miniconda3" "anaconda" "anaconda3"); do
    if [[ -d "${pfx}/${variant}" ]]; then
      __conda_setup "${pfx}/${variant}"
      break
    fi
  done
done
alias pytcov='py.test --cov-report html --cov'
