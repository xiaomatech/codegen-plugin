package com.github.xiaomatech.crud.intellij.plugin.model;

import java.util.List;

/**
 * @author xiaomatech
 */
public class Table {
    private String comment;
    private String name;
    private List<Column> columns;

    public Table(String comment, String name, List<Column> columns) {
        this.comment = comment;
        this.name = name;
        this.columns = columns;
    }

    public String getName() {
        return name;
    }

    public String getComment() {
        return comment;
    }

    public List<Column> getColumns() {
        return columns;
    }
}
