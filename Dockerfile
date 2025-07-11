FROM ruby:3.2-slim AS base

ENV BUNDLE_DEPLOYMENT=true \
    BUNDLE_PATH=/gems \
    APP_HOME=/app

# Instala dependencias del sistema
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    libcurl4-openssl-dev \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR $APP_HOME

# Copia solo los archivos de bundle para instalar dependencias
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.6.7 && \
    bundle config set without 'development test' && \
    bundle install --jobs 4 --retry 3 && \
    rm -rf /root/.bundle/cache

# Copia el resto del código
COPY . .

EXPOSE 3009

# Ejecuta Puma con configuración explícita
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
