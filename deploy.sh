#!/bin/bash

# ===== 1. 가장 최근 수정된 포스트 파일 가져오기 =====
LATEST_POST=$(ls -t content/posts/*.md | head -n 1)
BASENAME=$(basename "$LATEST_POST" .md)

# ===== 2. Hugo 빌드 =====
echo "🏗️  Hugo 사이트 빌드 중..."
hugo

# ===== 3. public 서브모듈 커밋 및 푸시 =====
echo "🚀 public (Pages) 배포 중..."
cd public
git add .
git commit -m "Deploy: $BASENAME"
git push origin main
cd ..

# ===== 4. 루트 저장소 커밋 및 푸시 =====
echo "📦 소스 저장소 커밋 중..."
git add .
git commit -m "Post: $BASENAME"
git push origin main

echo "✅ 배포 완료: $BASENAME"
