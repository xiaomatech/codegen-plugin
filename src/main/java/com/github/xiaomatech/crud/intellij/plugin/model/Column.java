package com.github.xiaomatech.crud.intellij.plugin.model;

/**
 * @author xiaomatech
 */
public class Column {
    private String comment;
    private String name;
    private int type;
    private boolean id;

    private int columnSize;
    private String isNullable;
    private String columnDefault;

    /**
     * @param comment 列注释
     * @param name    列名
     * @param type    列类型
     */
    public Column(String comment, String name, int type, int columnSize, String isNullable, String columnDefault) {
        this.comment = comment;
        this.name = name;
        this.type = type;
	this.columnSize = columnSize;
	this.isNullable = isNullable;
	this.columnDefault = columnDefault;
    }

    public String getIsNullable() {
        return isNullable;
    }

    public String getColumnDefault() {
        return columnDefault;
    }

    public int getColumnSize() {
        return columnSize;
    }

    public String getComment() {
        return comment;
    }

    public boolean isId() {
        return id;
    }

    public int getType() {
        return type;
    }

    public void setId(boolean id) {
        this.id = id;
    }
}
