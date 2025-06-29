FROM ruby:3.2

# Establecer el directorio de trabajo
WORKDIR /app

# Instalar dependencias del sistema necesarias para gems nativas (pg)
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copiar el Gemfile y Gemfile.lock (si existe)
COPY Gemfile Gemfile.lock* ./

# Instalar gems
RUN bundle install

# Copiar el resto del proyecto
COPY . .

# Exponer el puerto del servicio
EXPOSE 3009

# Comando de inicio

CMD ["puma", "app.rb", "-b", "tcp://0.0.0.0:3009"]
