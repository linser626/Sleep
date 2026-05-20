package com.example.wechat.common;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

@Data
public class Response {

    private boolean success;
    private String message;
    private Object data;
    private Map<String, Object> extra;

    private Response(boolean success, String message, Object data) {
        this.success = success;
        this.message = message;
        this.data = data;
        this.extra = new HashMap<>();
    }

    public static Response success() {
        return new Response(true, "操作成功", null);
    }

    public static Response success(Object data) {
        return new Response(true, "操作成功", data);
    }

    public static Response success(String message, Object data) {
        return new Response(true, message, data);
    }

    public static Response error(String message) {
        return new Response(false, message, null);
    }

    public static Response error(String message, Object data) {
        return new Response(false, message, data);
    }

    public Response addExtra(String key, Object value) {
        this.extra.put(key, value);
        return this;
    }
}