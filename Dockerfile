# Use PostgreSQL 15 specifically
FROM postgres:15

# Install build dependencies
RUN apt-get update \
    && apt-get install -y \
    postgresql-server-dev-15 \
    gcc \
    make \
    wget \
    unzip \
    libssl-dev \
    freetds-dev \
    freetds-bin \
    tdsodbc \
    odbc-postgresql \
    odbcinst \
    unixodbc \
    unixodbc-dev \
    default-libmysqlclient-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install mysql_fdw from source
RUN git clone https://github.com/EnterpriseDB/mysql_fdw.git \
    && cd mysql_fdw \
    && git checkout REL-2_9_0 \
    && make USE_PGXS=1 \
    && make USE_PGXS=1 install \
    && cd .. \
    && rm -rf mysql_fdw

# Install tds_fdw
RUN wget https://github.com/tds-fdw/tds_fdw/archive/refs/tags/v2.0.3.zip \
    && unzip v2.0.3.zip \
    && cd tds_fdw-2.0.3 \
    && make USE_PGXS=1 \
    && make USE_PGXS=1 install \
    && cd .. \
    && rm -rf tds_fdw-2.0.3 v2.0.3.zip