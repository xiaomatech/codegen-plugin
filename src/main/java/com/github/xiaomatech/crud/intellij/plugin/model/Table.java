package com.github.xiaomatech.crud.intellij.plugin.model;

import java.util.List;

/**
 * @author xiaomatech
 */
public class Table {
    private String comment;
    private String name;
    private List<Column> columns;
    private List<ForeignKey> importKeys;
    private List<ForeignKey> exportKeys;

    public Table(String comment, String name, List<Column> columns, List<ForeignKey> exportKeys, List<ForeignKey> importKeys) {
        this.comment = comment;
        this.name = name;
        this.columns = columns;
	this.exportKeys = exportKeys;	
	this.importKeys = importKeys;
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


    public List<ForeignKey> getImportKeys() {
        return importKeys;
    }

    public List<ForeignKey> getExportKeys() {
        return importKeys;
    }

}
