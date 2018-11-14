package com.qf.oa.entity;

import java.util.List;

/**
 * @Author Administrator
 * @Time 2018/11/8 9:42
 * @Version 1.0
 */
public class ResultInfo {

    private List<Info> suggestions;

    public List<Info> getSuggestions() {
        return suggestions;
    }

    public void setSuggestions(List<Info> suggestions) {
        this.suggestions = suggestions;
    }

    public static class Info {
        private String value;

        private String data;

        public String getValue() {
            return value;
        }

        public void setValue(String value) {
            this.value = value;
        }

        public String getData() {
            return data;
        }

        public void setData(String data) {
            this.data = data;
        }
    }
}
