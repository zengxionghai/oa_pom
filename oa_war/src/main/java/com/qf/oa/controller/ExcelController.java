package com.qf.oa.controller;

import com.qf.oa.entity.Department;
import com.qf.oa.entity.Employee;
import com.qf.oa.service.IDepService;
import com.qf.oa.service.IEmpService;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author Administrator
 * @Time 2018/11/9 15:11
 * @Version 1.0
 */
@Controller
@RequestMapping("/exc")
public class ExcelController {

    @Autowired
    private IDepService depService;

    @Autowired
    private IEmpService empService;

    /**
     * 跳转页面
     *
     * @return
     */
    @RequestMapping("/to")
    public String to() {
        return "excel";
    }

    /**
     * 部门信息导出
     *
     * @param response
     * @throws IOException
     */
    @RequestMapping("/depout")
    public void depOut(HttpServletResponse response) throws IOException {
        //创建HSSFWorkbook对象(excel的文档对象)
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFCellStyle style = wb.createCellStyle();
        HSSFCreationHelper creationHelper = wb.getCreationHelper();
        style.setDataFormat(creationHelper.createDataFormat().getFormat("yyyy-MM-dd"));

        //建立新的sheet对象（excel的表单）
        HSSFSheet sheet = wb.createSheet("部门表");
        sheet.setDefaultColumnWidth((short) 15);
        //在sheet里创建第一行，参数为行索引(excel的行)，可以是0～65535之间的任何一个
        HSSFRow row1 = sheet.createRow(0);
        //创建单元格（excel的单元格，参数为列索引，可以是0～255之间的任何一个
        HSSFCell cell = row1.createCell(0);
        //设置单元格内容
        cell.setCellValue("部门信息一览表");
        //合并单元格CellRangeAddress构造参数依次表示起始行，截至行，起始列， 截至列
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));

        //在sheet里创建第二行
        HSSFRow row2 = sheet.createRow(1);
        //创建单元格并设置单元格内容
        row2.createCell(0).setCellValue("编号");
        row2.createCell(1).setCellValue("名称");
        row2.createCell(2).setCellValue("描述");
        row2.createCell(3).setCellValue("创建时间");
        row2.createCell(4).setCellValue("父部门名称");
        row2.createCell(5).setCellValue("父部门编号");


        List<Department> deps = depService.queryAll();
        for (int i = 0; i < deps.size(); i++) {
            HSSFRow row = sheet.createRow(i + 2);
            row.createCell(0).setCellValue(deps.get(i).getId());
            row.createCell(1).setCellValue(deps.get(i).getDname());
            row.createCell(2).setCellValue(deps.get(i).getDinfo());
            HSSFCell createtime = row.createCell(3);
            createtime.setCellValue(deps.get(i).getCreatetime());
            createtime.setCellStyle(style);
            row.createCell(4).setCellValue(deps.get(i).getPname());
            row.createCell(5).setCellValue(deps.get(i).getPid());
        }

        OutputStream output = response.getOutputStream();
        response.reset();
        String filename = "部门信息表.xls";
        filename = URLEncoder.encode(filename, "utf-8");
        response.setHeader("Content-disposition", "attachment; filename=" + filename);
        response.setContentType("application/msexcel");
        wb.write(output);
        output.close();
    }


    /**
     * 员工信息导出
     *
     * @param response
     * @throws IOException
     */
    @RequestMapping("/empout")
    public void empOut(HttpServletResponse response) throws IOException {
        //创建HSSFWorkbook对象(excel的文档对象)
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFCellStyle style = wb.createCellStyle();
        HSSFCreationHelper creationHelper = wb.getCreationHelper();
        style.setDataFormat(creationHelper.createDataFormat().getFormat("yyyy-MM-dd"));

        //建立新的sheet对象（excel的表单）
        HSSFSheet sheet = wb.createSheet("员工表");
        sheet.setDefaultColumnWidth((short) 15);
        //在sheet里创建第一行，参数为行索引(excel的行)，可以是0～65535之间的任何一个
        HSSFRow row1 = sheet.createRow(0);
        //创建单元格（excel的单元格，参数为列索引，可以是0～255之间的任何一个
        HSSFCell cell = row1.createCell(0);
        //设置单元格内容
        cell.setCellValue("员工信息一览表");
        //合并单元格CellRangeAddress构造参数依次表示起始行，截至行，起始列， 截至列
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));

        //在sheet里创建第二行
        HSSFRow row2 = sheet.createRow(1);
        //创建单元格并设置单元格内容
        row2.createCell(0).setCellValue("编号");
        row2.createCell(1).setCellValue("姓名");
        row2.createCell(2).setCellValue("性别");
        row2.createCell(3).setCellValue("邮箱");
        row2.createCell(4).setCellValue("出生日期");
        row2.createCell(5).setCellValue("所属部门");
        row2.createCell(6).setCellValue("所属部门编号");
        row2.createCell(7).setCellValue("头像地址");


        List<Employee> emps = empService.queryAll();

        for (int i = 0; i < emps.size(); i++) {
            HSSFRow row = sheet.createRow(i + 2);
            row.createCell(0).setCellValue(emps.get(i).getId());
            row.createCell(1).setCellValue(emps.get(i).getName());
            if (emps.get(i).getSex() == 0) {
                row.createCell(2).setCellValue("女");
            } else {
                row.createCell(2).setCellValue("男");
            }
            row.createCell(3).setCellValue(emps.get(i).getEmail());
            HSSFCell createtime = row.createCell(4);
            createtime.setCellValue(emps.get(i).getBirthday());
            createtime.setCellStyle(style);
            if (emps.get(i).getDname() == null) {
                row.createCell(5).setCellValue("无");
            } else {
                row.createCell(5).setCellValue(emps.get(i).getDname());
            }
            row.createCell(6).setCellValue(emps.get(i).getDid());
            row.createCell(7).setCellValue(emps.get(i).getImage());
        }

        OutputStream output = response.getOutputStream();
        response.reset();
        String filename = "员工信息表.xls";
        filename = URLEncoder.encode(filename, "utf-8");
        response.setHeader("Content-disposition", "attachment; filename=" + filename);
        response.setContentType("application/msexcel");
        wb.write(output);
        output.close();
    }


    /**
     * 部门信息导入
     *
     * @throws IOException
     */
    @RequestMapping("/depin")
    public String depIn(MultipartFile file) throws IOException {
        List<Department> temp = new ArrayList();
        FileInputStream fileIn = new FileInputStream("");
        Workbook wb0 = new HSSFWorkbook(fileIn);
        //获取Excel文档中的第一个表单
        Sheet sht0 = wb0.getSheetAt(0);
        //对Sheet中的每一行进行迭代
        for (Row r : sht0) {

            //如果当前行的行号（从0开始）未达到2（第三行）则从新循环
            if (r.getRowNum() < 2) {
                continue;
            }
            Department dep = new Department();

//            dep.setId((int) r.getCell(0).getNumericCellValue());
            dep.setDname(r.getCell(1).getStringCellValue());
            dep.setDinfo(r.getCell(2).getStringCellValue());
            dep.setCreatetime(r.getCell(3).getDateCellValue());
            dep.setPid((int) r.getCell(5).getNumericCellValue());
            System.out.println(dep);
            temp.add(dep);

        }
//        depService.batchAdd(temp);
        fileIn.close();
        return "excel";
    }
}
