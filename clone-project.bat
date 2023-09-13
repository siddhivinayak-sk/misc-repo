echo "Arg 1: Group Name from where repos need to checkout"
echo "Arg 2: Local directory path"
echo "no --preserve-dir, --dry-run"

ghorg clone %1 --base-url=https://xxx.gitlab.com/ --scm=gitlab --token=xxx --path=%2
