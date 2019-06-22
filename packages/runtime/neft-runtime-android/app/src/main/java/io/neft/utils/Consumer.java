package io.neft.utils;

@FunctionalInterface
public interface Consumer<T> {
    void accept(T var);
}
