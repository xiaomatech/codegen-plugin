
package com.github.xiaomatech.crud.intellij.plugin.model;

/**
 * @author xiaomatech
 */
public class ForeignKey {
    private String fKName;
    private String fKColumnName;
    private String fKTableName;
    private String pKTableName;
    private String pKColumnName;
    private String pkName;
    private Integer updataRule;
    private Integer deleteRule;


    public ForeignKey(String fkName, String fKColumnName, String fKTableName, String pKTableName, String pKColumnName, String pkName, int updataRule, int deleteRule) {
        this.fKName = fkName;
        this.fKColumnName = fKColumnName;
        this.fKTableName = fKTableName;
        this.pKTableName = pKTableName;
        this.pKColumnName = pKColumnName;
        this.pkName = pkName;
        this.updataRule = updataRule;
        this.deleteRule = deleteRule;
    }

    public String getFkName() {
        return fKName;
    }

    public String getFkColumnName() {
        return fKColumnName;
    }

    public String getFkTableName() {
        return fKTableName;
    }

    public String getPkTableName() {
        return pKTableName;
    }

    public String getPkColumnName() {
        return pKColumnName;
    }

    public String getPkName() {
        return pkName;
    }

    public int getUpdataRule() {
        return updataRule;
    }

    public int getDeleteRule() {
        return deleteRule;
    }

}
