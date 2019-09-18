package com.github.xiaomatech.crud.intellij.plugin.wizard;

import com.github.xiaomatech.crud.intellij.plugin.icon.CrudIcons;
import com.github.xiaomatech.crud.intellij.plugin.setting.Conn;
import com.github.xiaomatech.crud.intellij.plugin.setting.CrudSettings;
import com.github.xiaomatech.crud.intellij.plugin.ui.CrudList;
import com.github.xiaomatech.crud.intellij.plugin.ui.CrudView;
import com.github.xiaomatech.crud.intellij.plugin.ui.ListElement;
import com.github.xiaomatech.crud.intellij.plugin.util.DbHelper;
import com.github.xiaomatech.crud.intellij.plugin.util.ProjectType;
import com.github.xiaomatech.crud.intellij.plugin.util.SelectionContext;
import com.intellij.ide.util.projectWizard.ModuleWizardStep;
import com.intellij.openapi.options.ConfigurationException;

import javax.swing.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author xiaomatech
 */
public class CrudConnStep extends ModuleWizardStep {
    private CrudView myCrudConnView;
    private CrudDbStep myDbStep;

    public CrudConnStep(CrudView crudConnView, CrudDbStep dbStep) {
        myCrudConnView = crudConnView;
        myDbStep = dbStep;
    }

    @Override
    public JComponent getComponent() {
        CrudList crudList = myCrudConnView.getCrudList();
        crudList.clearElement();
        List<Conn> conns = CrudSettings.getInstance().getConns();
        for (Conn conn : conns) {
            crudList.addElement(new ListElement(CrudIcons.MYSQL_CONN, conn.getName()));
        }
        return myCrudConnView.getComponent();
    }

    @Override
    public void updateDataModel() {

    }

    @Override
    public boolean validate() throws ConfigurationException {
        try {
            int index = myCrudConnView.getCrudList().getSelectedIndex();
            if (index == -1) {
                throw new Exception("请选择一个连接");
            }
            Conn conn = CrudSettings.getInstance().getConns().get(index);

            DbHelper dbHelper = new DbHelper(conn.getHost(), conn.getPort(), conn.getUsername(), conn.getPassword());
            List<String> databases = dbHelper.getDatabases();
            List<ListElement> ls = new ArrayList<>();
            for (String database : databases) {
                ls.add(new ListElement(CrudIcons.MYSQL_DB, database));
            }
            myDbStep.reloadListElements(ls);
            myDbStep.reloadPathLabel(conn.getName() + " >");
            myDbStep.reloadDbHelper(dbHelper);
            SelectionContext.setProjectType(ProjectType.SPRING_BOOT);
            SelectionContext.setConn(conn);
        } catch (Exception e) {
            throw new ConfigurationException(e.getMessage(), "连接打开失败");
        }
        return super.validate();
    }
}
