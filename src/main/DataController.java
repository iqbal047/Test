
package main;

import dao.DatabaseConnector;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JComboBox;


public class DataController {
    public static void addStudent(String id,String name, String gender, String address, String group, String cls, String batch, String contact, String date){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL saveStudent(?, ?, ?, ?, ?, ?, ?, ?, ?)}");
            cstmt.setString(1, id);
            cstmt.setString(2, name);
            cstmt.setString(3, cls);
            cstmt.setString(4, address);
            cstmt.setString(5, contact);
            cstmt.setString(6, batch);
            cstmt.setString(7, date);
            cstmt.setString(8, group);
            cstmt.setString(9, gender);
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void loadStudentsId(JComboBox combo){
        Connection con = null;
        CallableStatement cstmt = null;
        ResultSet rst = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL allStudentsId()}");
            cstmt.execute();
            rst = cstmt.getResultSet();
            List idlst = new ArrayList();
            while(rst.next()){
                idlst.add(rst.getString(1));
            }
            combo.setModel(new DefaultComboBoxModel(idlst.toArray()));
            combo.insertItemAt("Select or Write ID", 0);
            combo.setSelectedIndex(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
                rst.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void addTeacher(String id, String name, String gender, String address, String subject, String contact, String date){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL saveTeacher(?, ?, ?, ?, ?, ?, ?)}");
            cstmt.setString(1, id);
            cstmt.setString(2, name);
            cstmt.setString(3, address);
            cstmt.setString(4, subject);
            cstmt.setString(5, contact);
            cstmt.setString(6, gender);
            cstmt.setString(7, date);
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void loadTeachersId(JComboBox combo){
        Connection con = null;
        CallableStatement cstmt = null;
        ResultSet rst = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL allTeachersId()}");
            cstmt.execute();
            rst = cstmt.getResultSet();
            List idlst = new ArrayList();
            while(rst.next()){
                idlst.add(rst.getString(1));
            }
            combo.setModel(new DefaultComboBoxModel(idlst.toArray()));
            combo.insertItemAt("Select or Write ID", 0);
            combo.setSelectedIndex(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
                rst.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void deleteStudent(String id){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL removeStudent(?)}");
            cstmt.setString(1, id);
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void updateStudent(String id,String name, String gender, String address, String group, String cls, String batch, String contact){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL upStudent(?, ?, ?, ?, ?, ?, ?, ?)}");
            cstmt.setString(1, id);
            cstmt.setString(2, name);
            cstmt.setString(3, cls);
            cstmt.setString(4, address);
            cstmt.setString(5, contact);
            cstmt.setString(6, batch);
            cstmt.setString(7, group);
            cstmt.setString(8, gender);
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void deleteTeacher(String id){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL removeTeacher(?)}");
            cstmt.setString(1, id);
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    public static void updateTeacher(String id, String name, String gender, String address, String subject, String contact){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL upTeacher(?, ?, ?, ?, ?, ?)}");
            cstmt.setString(1, id);
            cstmt.setString(2, name);
            cstmt.setString(3, address);
            cstmt.setString(4, subject);
            cstmt.setString(5, contact);
            cstmt.setString(6, gender);
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void saveStudentPayment(String id, String name, String month, String amount, String date){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL getPayment(?, ?, ?, ?, ?)}");
            cstmt.setString(1, id);
            cstmt.setString(2, name);
            cstmt.setString(3, month);
            cstmt.setString(4, amount);
            cstmt.setString(5, date);
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void saveTeacherPayment(String id, String name, String month, String amount, String date){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL teacherPayment(?, ?, ?, ?, ?)}");
            cstmt.setString(1, id);
            cstmt.setString(2, name);
            cstmt.setString(3, month);
            cstmt.setString(4, amount);
            cstmt.setString(5, date);
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
     public static void saveExpense(String name, String amount, String date){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL expense(?, ?, ?)}");

            cstmt.setString(1, name);
            cstmt.setString(2, amount);
            cstmt.setString(3, date);
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void loadStudentsName(JComboBox combo){
        Connection con = null;
        CallableStatement cstmt = null;
        ResultSet rst = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL allStudentsName()}");
            cstmt.execute();
            rst = cstmt.getResultSet();
            List idlst = new ArrayList();
            while(rst.next()){
                idlst.add(rst.getString(1));
            }
            combo.setModel(new DefaultComboBoxModel(idlst.toArray()));
            combo.insertItemAt("Select or Write Name", 0);
            combo.setSelectedIndex(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
                rst.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void loadStudentsClass(JComboBox combo){
        Connection con = null;
        CallableStatement cstmt = null;
        ResultSet rst = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL classStu()}");
            cstmt.execute();
            rst = cstmt.getResultSet();
            List idlst = new ArrayList();
            while(rst.next()){
                idlst.add(rst.getString(1));
            }
            combo.setModel(new DefaultComboBoxModel(idlst.toArray()));
            combo.insertItemAt("Select Class", 0);
            combo.setSelectedIndex(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
                rst.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void loadStudentsBatch(JComboBox combo){
        Connection con = null;
        CallableStatement cstmt = null;
        ResultSet rst = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL searchBatch()}");
            cstmt.execute();
            rst = cstmt.getResultSet();
            List idlst = new ArrayList();
            while(rst.next()){
                idlst.add(rst.getString(1));
            }
            combo.setModel(new DefaultComboBoxModel(idlst.toArray()));
            combo.insertItemAt("Select Batch", 0);
            combo.setSelectedIndex(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
                rst.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void loadTeachersName(JComboBox combo){
        Connection con = null;
        CallableStatement cstmt = null;
        ResultSet rst = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL allTeachersName()}");
            cstmt.execute();
            rst = cstmt.getResultSet();
            List idlst = new ArrayList();
            while(rst.next()){
                idlst.add(rst.getString(1));
            }
            combo.setModel(new DefaultComboBoxModel(idlst.toArray()));
            combo.insertItemAt("Select or Write Name", 0);
            combo.setSelectedIndex(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
                rst.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void loadTeachersSubject(JComboBox combo){
        Connection con = null;
        CallableStatement cstmt = null;
        ResultSet rst = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL subjectofTeachers()}");
            cstmt.execute();
            rst = cstmt.getResultSet();
            List idlst = new ArrayList();
            while(rst.next()){
                idlst.add(rst.getString(1));
            }
            combo.setModel(new DefaultComboBoxModel(idlst.toArray()));
            combo.insertItemAt("Select Subject", 0);
            combo.setSelectedIndex(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
                rst.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void updateStudentPayment(String pid, String sid,String name, String month, String amount, String date){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL upStudentPayment(?, ?, ?, ?, ?, ?)}");
            cstmt.setString(1, pid);
            cstmt.setString(2, sid);
            cstmt.setString(3, name);
            cstmt.setString(4, month);
            cstmt.setString(5, amount);
            cstmt.setString(6, date);
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void deleteStudentPayment(String id){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL delStudentPayment(?)}");
            cstmt.setString(1, id);
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void updateTeacherPayment(String pid, String id, String name, String month, String amount, String date){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL upTeacherPayment(?, ?, ?, ?, ?, ?)}");
            cstmt.setString(1, pid);
            cstmt.setString(2, id);
            cstmt.setString(3, name);
            cstmt.setString(4, month);
            cstmt.setString(5, amount);
            cstmt.setString(6, date);
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void deleteTeacherPayment(String pid, String tid){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL delTeacherPayment(?, ?)}");
            cstmt.setString(1, pid);
            cstmt.setString(2, tid);
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void loadAdminAccountId(JComboBox combo){
        Connection con = null;
        CallableStatement cstmt = null;
        ResultSet rst = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL getAllAdminAccId()}");
            cstmt.execute();
            rst = cstmt.getResultSet();
            List idlst = new ArrayList();
            while(rst.next()){
                idlst.add(rst.getString(1));
            }
            combo.setModel(new DefaultComboBoxModel(idlst.toArray()));
            combo.insertItemAt("Select or Write ID", 0);
            combo.setSelectedIndex(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
                rst.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void loadTeacherAccountId(JComboBox combo){
        Connection con = null;
        CallableStatement cstmt = null;
        ResultSet rst = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL getAllTeacherAccId()}");
            cstmt.execute();
            rst = cstmt.getResultSet();
            List idlst = new ArrayList();
            while(rst.next()){
                idlst.add(rst.getString(1));
            }
            combo.setModel(new DefaultComboBoxModel(idlst.toArray()));
            combo.insertItemAt("Select or Write ID", 0);
            combo.setSelectedIndex(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
                rst.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void addAdminAccount(String uname,String pass){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL insertAdminLogin(?, ?)}");
            cstmt.setString(1, uname);
            cstmt.setString(2, pass);
            
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    public static void addTeacherAccount(String uname,String pass){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL insertTeacherLogin(?, ?)}");
            cstmt.setString(1, uname);
            cstmt.setString(2, pass);
            
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void deleteAdminAcc(String id){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL remAdminAccount(?)}");
            cstmt.setString(1, id);
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void deleteTeacherAcc(String id){
        Connection con = null;
        CallableStatement cstmt = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareCall("{CALL remTeacherAccount(?)}");
            cstmt.setString(1, id);
            cstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void loadStudentsPaymentId(JComboBox combo){
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rst = null;
        try {
            con = DatabaseConnector.getConnection();
            pstmt = con.prepareStatement("select p_id from get_payment");
            pstmt.executeQuery();
            rst = pstmt.getResultSet();
            List idlst = new ArrayList();
            while(rst.next()){
                idlst.add(rst.getString(1));
            }
            combo.setModel(new DefaultComboBoxModel(idlst.toArray()));
            combo.insertItemAt("Select or Write ID", 0);
            combo.setSelectedIndex(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                pstmt.close();
                rst.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    public static void loadTeachersPaymentId(JComboBox combo){
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rst = null;
        try {
            con = DatabaseConnector.getConnection();
            pstmt = con.prepareStatement("select tp_id from teacher_payment");
            pstmt.executeQuery();
            rst = pstmt.getResultSet();
            List idlst = new ArrayList();
            while(rst.next()){
                idlst.add(rst.getString(1));
            }
            combo.setModel(new DefaultComboBoxModel(idlst.toArray()));
            combo.insertItemAt("Select or Write Payment ID", 0);
            combo.setSelectedIndex(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                pstmt.close();
                rst.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void loadExamId(JComboBox combo){
        Connection con = null;
        PreparedStatement cstmt = null;
        ResultSet rst = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareStatement("select id from exam");
            cstmt.execute();
            rst = cstmt.getResultSet();
            List idlst = new ArrayList();
            while(rst.next()){
                idlst.add(rst.getString(1));
            }
            combo.setModel(new DefaultComboBoxModel(idlst.toArray()));
            combo.insertItemAt("Select or Write Exam ID", 0);
            combo.setSelectedIndex(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
                rst.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    public static void loadResultId(JComboBox combo){
        Connection con = null;
        PreparedStatement cstmt = null;
        ResultSet rst = null;
        try {
            con = DatabaseConnector.getConnection();
            cstmt = con.prepareStatement("select rid from result");
            cstmt.execute();
            rst = cstmt.getResultSet();
            List idlst = new ArrayList();
            while(rst.next()){
                idlst.add(rst.getString(1));
            }
            combo.setModel(new DefaultComboBoxModel(idlst.toArray()));
            combo.insertItemAt("Select or Write Result ID", 0);
            combo.setSelectedIndex(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                con.close();
                cstmt.close();
                rst.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
