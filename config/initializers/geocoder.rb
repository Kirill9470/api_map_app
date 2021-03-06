Geocoder.configure(
    # Geocoding options
    #timeout: 100000,                 # geocoding service timeout (secs)
    lookup: :yandex,            # name of geocoding service (symbol)
    # language: :en,              # ISO-639 language code
    use_https: true,           # use HTTPS for lookup requests? (if supported)
    # http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
    # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
    api_key: '960cb057-bf0b-48ee-918f-e2bf63252d9c',               # API key for geocoding service
    # cache: nil,                 # cache object (must respond to #[], #[]=, and #keys)
    # cache_prefix: 'geocoder:',  # prefix (string) to use for all cache keys

    # Exceptions that should not be rescued by default
    # (if you want to implement custom error handling);
    # supports SocketError and Timeout::Error
    always_raise: :all,

    # Calculation options
    units: :km,                 # :km for kilometers or :mi for miles
    # distances: :linear          # :spherical or :linear
    )