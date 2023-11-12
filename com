#!/bin/bash

# .gitignore 파일 경로
gitignore_file=".gitignore"

# 무시할 파일 이름
file_to_ignore="com"

# .gitignore 파일이 없는 경우 생성
if [ ! -f "$gitignore_file" ]; then
    touch "$gitignore_file"
fi

# .gitignore 파일에 파일을 추가하기 전에 이미 존재하는지 확인
if grep -q "$file_to_ignore" "$gitignore_file"; then
    echo "파일 이미 .gitignore에 추가되어 있습니다."
else
    echo "$file_to_ignore" >> "$gitignore_file"
    echo "파일을 .gitignore에 추가했습니다."
fi

if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Error: 숫자만 입력." >&2
    exit 1
fi

g++ -o task"$1" task"$1".cpp