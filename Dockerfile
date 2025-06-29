FROM ruby:3.2

WORKDIR /app

# Dependencias del sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copiar y preparar gems
COPY Gemfile Gemfile.lock* ./
RUN bundle install

# Copiar el resto del proyecto
COPY . .

EXPOSE 3009

CMD ["puma", "-b", "tcp://0.0.0.0:3009"]
