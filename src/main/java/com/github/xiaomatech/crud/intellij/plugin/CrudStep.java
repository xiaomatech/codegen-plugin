package com.github.xiaomatech.crud.intellij.plugin;

import com.intellij.openapi.options.ConfigurationException;

import javax.swing.*;

/**
 * @author xiaomatech
 */
public interface CrudStep {
    JComponent getComponent();

    boolean validate() throws ConfigurationException;

    void finish();
}
