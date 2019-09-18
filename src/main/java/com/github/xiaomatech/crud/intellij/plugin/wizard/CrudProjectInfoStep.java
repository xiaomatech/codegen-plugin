package com.github.xiaomatech.crud.intellij.plugin.wizard;

import com.github.xiaomatech.crud.intellij.plugin.CrudBundle;
import com.github.xiaomatech.crud.intellij.plugin.util.SelectionContext;
import com.intellij.ide.util.projectWizard.ModuleWizardStep;
import com.intellij.openapi.options.ConfigurationException;
import com.intellij.openapi.util.text.StringUtil;

import javax.swing.*;

/**
 * @author xiaomatech
 */
public class CrudProjectInfoStep extends ModuleWizardStep {
    private JPanel myMainPanel;
    private JTextField myGroupIdField;
    private JTextField myArtifactIdField;
    private JTextField myVersionField;
    private JTextField myPackageField;
    private JComboBox myFrameComboBox;

    @Override
    public JComponent getComponent() {
        return myMainPanel;
    }

    @Override
    public void updateDataModel() {

    }

    @Override
    public boolean validate() throws ConfigurationException {
        if (StringUtil.isEmptyOrSpaces(myGroupIdField.getText())) {
            throw new ConfigurationException(CrudBundle.message("projectinfo.validate.groupid"));
        }
        if (StringUtil.isEmptyOrSpaces(myArtifactIdField.getText())) {
            throw new ConfigurationException(CrudBundle.message("projectinfo.validate.artifactid"));
        }
        if (StringUtil.isEmptyOrSpaces(myVersionField.getText())) {
            throw new ConfigurationException(CrudBundle.message("projectinfo.validate.version"));
        }
        if (StringUtil.isEmptyOrSpaces(myPackageField.getText())) {
            throw new ConfigurationException(CrudBundle.message("projectinfo.validate.package"));
        }

        SelectionContext.setGroupId(myGroupIdField.getText());
        SelectionContext.setArtifactId(myArtifactIdField.getText());
        SelectionContext.setVersion(myVersionField.getText());
        SelectionContext.setPackage(myPackageField.getText());
        SelectionContext.setOrmType(myFrameComboBox.getSelectedIndex());
        return super.validate();
    }

    public JTextField getArtifactIdField() {
        return myArtifactIdField;
    }
}
