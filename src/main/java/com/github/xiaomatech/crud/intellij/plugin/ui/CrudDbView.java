package com.github.xiaomatech.crud.intellij.plugin.ui;

import com.intellij.ui.components.JBLabel;
import com.intellij.ui.components.JBScrollPane;

import javax.swing.*;

/**
 * @author xiaomatech
 */
public class CrudDbView implements CrudView {
    private JPanel myMainPanel;
    private JList myDbList;
    private JLabel myDbLabel;
    private JLabel myPathLabel;
    private JScrollPane myScrollPane;

    @Override
    public CrudList getCrudList() {
        return (CrudList) myDbList;
    }

    @Override
    public JComponent getComponent() {
        return myMainPanel;
    }

    public JLabel getPathLabel() {
        return myPathLabel;
    }

    private void createUIComponents() {
        // TODO: place custom component creation code here
        myScrollPane = new JBScrollPane();
        myDbLabel = new JBLabel();
    }
}
