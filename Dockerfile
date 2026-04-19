# Gotenberg مخصص مع خطوط عربية كاملة
# لتحسين دقة تحويل ملفات Excel العربية إلى PDF
#
# يضيف على صورة Gotenberg الافتراضية:
#   - خطوط عربية من Debian (Amiri, KACST, Scheherazade, Noto Arabic...)
#   - Cairo و Tajawal من Google Fonts (المستخدمة في واجهة المشروع)
#
# كيفية النشر على Railway:
# 1. أنشئ مستودع Git جديد (GitHub) يحتوي على هذا الملف باسم "Dockerfile" فقط
# 2. في Railway: New Project → Deploy from GitHub → اختر المستودع
# 3. Railway يكشف الـ Dockerfile تلقائياً ويبني الصورة (~5 دقائق)
# 4. انسخ الـ URL العام وضعه في GOTENBERG_URL في Supabase

FROM gotenberg/gotenberg:8

USER root

# ═══════════════════════════════════════════════════════════
# 1. تثبيت الخطوط العربية من مستودعات Debian الرسمية
# ═══════════════════════════════════════════════════════════
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Noto — الأساسي لدعم متعدد اللغات
    fonts-noto-core \
    fonts-noto-extra \
    fonts-noto-mono \
    fonts-noto-color-emoji \
    # خطوط عربية متخصصة
    fonts-hosny-amiri \
    fonts-kacst-one \
    fonts-sil-scheherazade \
    fonts-arabeyes \
    fonts-farsiweb \
    # خطوط احتياطية عامة
    fonts-freefont-ttf \
    fonts-liberation \
    fonts-liberation2 \
    fonts-dejavu-core \
    fonts-dejavu-extra \
    # أدوات تحميل
    wget \
    unzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ═══════════════════════════════════════════════════════════
# 2. تحميل Cairo و Tajawal مباشرة من مستودع Google Fonts على GitHub
#    (أكثر موثوقية من Google Fonts API — روابط ثابتة)
# ═══════════════════════════════════════════════════════════
RUN mkdir -p /usr/share/fonts/truetype/google-arabic && \
    cd /usr/share/fonts/truetype/google-arabic && \
    # Cairo — Variable font يغطي كل الأوزان
    wget -q "https://github.com/google/fonts/raw/main/ofl/cairo/Cairo%5Bslnt%2Cwght%5D.ttf" -O "Cairo-Variable.ttf" && \
    # Tajawal — كل الأوزان (7 ملفات)
    wget -q "https://github.com/google/fonts/raw/main/ofl/tajawal/Tajawal-ExtraLight.ttf" && \
    wget -q "https://github.com/google/fonts/raw/main/ofl/tajawal/Tajawal-Light.ttf" && \
    wget -q "https://github.com/google/fonts/raw/main/ofl/tajawal/Tajawal-Regular.ttf" && \
    wget -q "https://github.com/google/fonts/raw/main/ofl/tajawal/Tajawal-Medium.ttf" && \
    wget -q "https://github.com/google/fonts/raw/main/ofl/tajawal/Tajawal-Bold.ttf" && \
    wget -q "https://github.com/google/fonts/raw/main/ofl/tajawal/Tajawal-ExtraBold.ttf" && \
    wget -q "https://github.com/google/fonts/raw/main/ofl/tajawal/Tajawal-Black.ttf" && \
    chmod 644 /usr/share/fonts/truetype/google-arabic/*.ttf

# ═══════════════════════════════════════════════════════════
# 3. تحديث خزينة الخطوط حتى يراها LibreOffice
# ═══════════════════════════════════════════════════════════
RUN fc-cache -f -v && \
    echo "═══ الخطوط العربية المثبتة ═══" && \
    fc-list :lang=ar | head -30

USER gotenberg

# نفس الـ entrypoint الافتراضي لـ Gotenberg (لا حاجة لتعديله)
