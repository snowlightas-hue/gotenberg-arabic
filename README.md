# Gotenberg Arabic — خادم تحويل Excel إلى PDF بدعم عربي كامل

صورة Docker مخصصة لـ [Gotenberg](https://gotenberg.dev/) مع خطوط عربية كاملة لضمان دقة تحويل ملفات Excel العربية إلى PDF.

## الخطوط المُضمّنة
- **Noto** (Core + Extra + Mono + Emoji)
- **Amiri** — خط نسخي كلاسيكي
- **KACST** — مجموعة خطوط عربية شاملة
- **Scheherazade** — خط نسخي عالي الجودة
- **Cairo** — Variable font من Google Fonts
- **Tajawal** — جميع الأوزان (7 ملفات)
- **Liberation + DejaVu + FreeFont** — خطوط احتياطية

## النشر على Railway
1. ادفع هذا المستودع إلى GitHub
2. في [Railway](https://railway.app): **New Project** → **Deploy from GitHub** → اختر المستودع
3. Railway يكشف الـ `Dockerfile` تلقائياً ويبني الصورة (~5 دقائق)
4. انسخ الـ URL العام واستخدمه كـ `GOTENBERG_URL`

## الاستخدام
```bash
# تحويل ملف Excel إلى PDF
curl --request POST \
  --url http://localhost:3000/forms/libreoffice/convert \
  --header 'Content-Type: multipart/form-data' \
  -F files=@file.xlsx \
  -o output.pdf
```
