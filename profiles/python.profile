PYTHONDONTWRITEBYTECODE=dontwritedat

pip_install_good_stuff() {
    echo "jfyi, this is usually overkill"
    pip install --upgrade pip ipython ipdb jedi proselint grip pdbpp importmagic epc pytest python-language-server pyls-mypy pyls-isort pylint autoflake
}
