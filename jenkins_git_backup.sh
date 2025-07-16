#!/bin/bash


SRC_DIR="/var/lib/jenkins"
DEST_DIR="/home/ubuntu/jenkins-backup"
BRANCH="main"
COMMIT_MSG="Automated Jenkins backup on $(date +'%Y-%m-%d %H:%M:%S')"


sudo rsync -a --delete "$SRC_DIR/" "$DEST_DIR/"
sudo chown -R ubuntu:ubuntu "$DEST_DIR"


cd "$DEST_DIR" || exit 1


if [ ! -d .git ]; then
  echo "❌ ERROR: $DEST_DIR is not a Git repository."
  exit 1
fi

echo "📦 Committing changes..."
git add .
git commit -m "$COMMIT_MSG" || echo "📝 No changes to commit."

echo "🚀 Pushing to remote branch $BRANCH..."
git push origin "$BRANCH"


