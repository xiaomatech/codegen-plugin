package com.github.xiaomatech.crud.intellij.plugin.setting;

import java.util.ArrayList;
import java.util.List;

/**
 * @author xiaomatech
 */
public class CrudState {

    private List<Conn> conns = new ArrayList<>();

    public List<Conn> getConns() {
        return conns;
    }

    public void setConns(List<Conn> conns) {
        this.conns = conns;
    }
}
