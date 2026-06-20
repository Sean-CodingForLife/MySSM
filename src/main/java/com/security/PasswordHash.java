package com.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public final class PasswordHash {

    private static final BCryptPasswordEncoder ENCODER = new BCryptPasswordEncoder(12);

    private PasswordHash() {
    }

    public static String hash(String rawPassword) {
        return ENCODER.encode(rawPassword);
    }

    public static boolean matches(String rawPassword, String passwordHash) {
        if (rawPassword == null || passwordHash == null) {
            return false;
        }
        return ENCODER.matches(rawPassword, passwordHash);
    }
}
