#!/bin/bash
# ================================================
# Render Deployment Script for Django
# Author: Oscar Kamau
# ================================================

# 1. Install essential packages
echo "👉 Installing dependencies..."
pip install --upgrade pip
pip install gunicorn whitenoise dj-database-url psycopg2-binary

# 2. Freeze requirements
echo "👉 Creating requirements.txt..."
pip freeze > requirements.txt

# 3. Create Procfile
echo "👉 Creating Procfile..."
cat <<EOL > Procfile
web: gunicorn lotto_app.wsgi
EOL

# ⚠️ Replace 'projectname' with your actual Django project folder name (the one with settings.py)
# e.g., if your settings.py is inside mysite/settings.py, use 'mysite.wsgi'

# 4. Update Django settings.py instructions
echo "👉 Reminder: Please update settings.py as follows:"
echo "   - ALLOWED_HOSTS = ['.onrender.com']"
echo "   - Add 'whitenoise.middleware.WhiteNoiseMiddleware' after SecurityMiddleware in MIDDLEWARE"
echo "   - Ensure STATIC_ROOT is set: STATIC_ROOT = BASE_DIR / 'staticfiles'"

# 5. Collect static files
echo "👉 Collecting static files..."
python manage.py collectstatic --noinput

# 6. Initialize Git (if not done already)
if [ ! -d .git ]; then
  echo "👉 Initializing Git repository..."
  git init
  git branch -M main
fi

# 7. Add & Commit
echo "👉 Adding files to Git..."
git add .
git commit -m "Prepare Django app for Render deployment"

# 8. Push to GitHub
echo "👉 Please enter your GitHub repo URL (https://github.com/KamauDev-maker/app-lotto):"
read REPO_URL
git remote add origin $REPO_URL 2>/dev/null || git remote set-url origin $REPO_URL
git push -u origin main

# 9. Final instructions for Render
echo "✅ Code pushed to GitHub!"
echo "👉 Now go to https://render.com:"
echo "   - Click 'New Web Service'"
echo "   - Connect your GitHub repo"
echo "   - Build Command: pip install -r requirements.txt && python manage.py migrate && python manage.py collectstatic --noinput"
echo "   - Start Command: gunicorn lotto_app.wsgi"
echo "🚀 Your app will be live at "https://app-lotto.onrender.com"