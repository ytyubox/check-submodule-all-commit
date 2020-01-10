# check-submodule-all-commit

## Installation
```bash
git clone https://github.com/ytyubox/check-submodule-all-commit
make -C check-submodule-all-commit
cp check-submodule-all-commit/pre-commit pre-commit
rm -rf check-submodule-all-commit
```
Will generate a execute file name `pre-commit`

## Usage

```bash
git submodule add https://github.com/ytyubox/check-submodule-all-commit
touch check-submodule-all-commit/UncommitFile
touch commitedFile
git add commitedFile
git commit -m 'commited'

```

