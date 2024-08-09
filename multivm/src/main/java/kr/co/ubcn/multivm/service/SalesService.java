package kr.co.ubcn.multivm.service;

import kr.co.ubcn.multivm.mapper.*;
import kr.co.ubcn.multivm.model.*;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class SalesService {
    @Autowired
    CompanyMapper companyMapper;
    @Autowired
    OrganizationMapper organizationMapper;
    @Autowired
    VendingMachineMapper vendingMachineMapper;
    @Autowired
    SalesMapper salesMapper;
    @Autowired
    SalesProductMapper salesProductMapper;

    public ModelAndView setSalesPage(ModelAndView mav, HttpServletRequest request, String page){
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("loginUser");

        SimpleDateFormat format = new SimpleDateFormat ( "yyyyMMdd");
        Calendar time = Calendar.getInstance();
        String today = format.format(time.getTime());

        Map<String, Object> map = new HashMap<>();
        if(user.getAuth()!=0){
            map.put("companySeq",user.getCompanySeq());
        }
        if(user.getAuth()==3) {
            map.put("organizationSeq", user.getOrganizationSeq());
        }
        if(user.getAuth()==4){
            map.put("auth",4);
            map.put("userSeq",user.getSeq());
        }
        List<Organization> orgList = organizationMapper.getOrganizationList(map);
        mav.addObject("companyList",companyMapper.getAllCompanyList())
                .addObject("orgList",orgList)
                .addObject("vmList",vendingMachineMapper.getSearchVM2(map));

        /*Map<String, Object> sales = new HashMap<>();
        sales.putAll(map);
        if(user.getAuth()!=0&&user.getAuth()!=1){
            if(!vmList.isEmpty()){
                sales.put("vmId", vmList.get(0).vmId);
                sales.put("terminalId",vmList.get(0).terminalId);
            }else{
                sales.put("vmId", "00000");
                sales.put("terminalId","00000");
            }
        }*/
        map.put("sDate",today);
        map.put("eDate",today);
        /*Sales sales = new Sales();
        sales.setCompanySeq(user.getCompanySeq());
        if(user.getAuth()!=0&&user.getAuth()!=1){
            sales.setOrganizationSeq(user.getOrganizationSeq());
            if(!vmList.isEmpty()){
                sales.setVmId(vmList.get(0).vmId);
                sales.setTerminalId(vmList.get(0).terminalId);
            }else{
                sales.setVmId("00000");
                sales.setTerminalId("00000");
            }
        }
        sales.setSDate(today);
        sales.setEDate(today);*/

        switch (page){
            case "transaction":
                mav.addObject("salesList",salesMapper.getSalesList(map))
                        .setViewName("sales/transaction");

                break;
            case "salesReport" :
                mav.addObject("dailySalesList",salesMapper.getDailySalesList(map))
                        .setViewName("sales/report");
                break;
            default:
        }


        return mav;
    }

    public Workbook downExcel_deadLineSalesData(Sales sales, HttpServletResponse response,List<SalesProduct> result) throws IOException {
        //List<SalesProduct> result = salesProductMapper.getDeadlineSalesData(sales);
        //System.out.println("sa;es일단 학이: "+sales);
        DecimalFormat decFormat = new DecimalFormat("###,###");
        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("거래내역");
        Row row = null;
        Cell cell = null;
        int rowNum = 1;

        int count = 0;
        int amount = 0;
        int total_count = 0;
        int total_amount = 0;
        String pre_date = "";

        sheet.setColumnWidth(0,7000);
        sheet.setColumnWidth(1,6000);
        sheet.setColumnWidth(2,4000);
        sheet.setColumnWidth(3,4000);
        sheet.setColumnWidth(4,7000);
        sheet.setColumnWidth(5,5000);
        sheet.setColumnWidth(6,7000);
        sheet.setColumnWidth(7,4000);
        sheet.setColumnWidth(8,2000);

        Font headerFont = wb.createFont();
        headerFont.setBold(true);

        CellStyle headStyle = wb.createCellStyle();
        headStyle.setBorderBottom(BorderStyle.THIN);
        headStyle.setBorderLeft(BorderStyle.THIN);
        headStyle.setBorderRight(BorderStyle.THIN);
        headStyle.setBorderTop(BorderStyle.THIN);
        headStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headStyle.setAlignment(HorizontalAlignment.CENTER);
        headStyle.setFont(headerFont);

        CellStyle subTotalStyle = wb.createCellStyle();
        subTotalStyle.setBorderTop(BorderStyle.THIN);
        subTotalStyle.setBorderBottom(BorderStyle.THIN);
        subTotalStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
        subTotalStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
        subTotalStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        CellStyle defaultStyle = wb.createCellStyle();
        defaultStyle.setBorderBottom(BorderStyle.THIN);
        defaultStyle.setBorderLeft(BorderStyle.THIN);
        defaultStyle.setBorderRight(BorderStyle.THIN);
        defaultStyle.setBorderTop(BorderStyle.THIN);

        CellStyle subTotalStyle2 = wb.createCellStyle();
        subTotalStyle2.setBorderTop(BorderStyle.THIN);
        subTotalStyle2.setBorderRight(BorderStyle.THIN);
        subTotalStyle2.setBorderBottom(BorderStyle.THIN);
        subTotalStyle2.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
        subTotalStyle2.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        CellStyle totalStyle = wb.createCellStyle();
        totalStyle.setBorderTop(BorderStyle.THIN);
        totalStyle.setBorderBottom(BorderStyle.THIN);
        totalStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
        totalStyle.setFillForegroundColor(IndexedColors.GOLD.getIndex());
        totalStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        totalStyle.setFont(headerFont);

        CellStyle numberStyle = wb.createCellStyle();
        numberStyle.setBorderBottom(BorderStyle.THIN);
        numberStyle.setBorderLeft(BorderStyle.THIN);
        numberStyle.setBorderRight(BorderStyle.THIN);
        numberStyle.setBorderTop(BorderStyle.THIN);
        numberStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));

        CellStyle shipResultFStyle = wb.createCellStyle();
        shipResultFStyle.setBorderBottom(BorderStyle.THIN);
        shipResultFStyle.setBorderLeft(BorderStyle.THIN);
        shipResultFStyle.setBorderRight(BorderStyle.THIN);
        shipResultFStyle.setBorderTop(BorderStyle.THIN);
        shipResultFStyle.setFillForegroundColor(IndexedColors.RED.getIndex());
        shipResultFStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        // Header
        sheet.addMergedRegion(new CellRangeAddress(1,1,1,6));
        sheet.addMergedRegion(new CellRangeAddress(2,2,1,6));
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("페이지명");
        cell.setCellStyle(subTotalStyle2);
        cell = row.createCell(1);
        cell.setCellValue("거래내역");
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("검색조건");
        cell.setCellStyle(subTotalStyle2);
        cell = row.createCell(1);
        cell.setCellValue("집계기준=거래일&집계기간="+sales.getSDate()+"-"+sales.getEDate()+"&소속="+sales.getOrganizationName()+"&설치위치="+sales.getPlace()+"");

        rowNum++;
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("소속/조직");
        cell.setCellStyle(headStyle);
        cell = row.createCell(1);
        cell.setCellValue("설치위치");
        cell.setCellStyle(headStyle);
        cell = row.createCell(2);
        cell.setCellValue("자판기ID");
        cell.setCellStyle(headStyle);
        cell = row.createCell(3);
        cell.setCellValue("단말기ID");
        cell.setCellStyle(headStyle);
        cell = row.createCell(4);
        cell.setCellValue("거래일시");
        cell.setCellStyle(headStyle);
        cell = row.createCell(5);
        cell.setCellValue("거래번호");
        cell.setCellStyle(headStyle);
        cell = row.createCell(6);
        cell.setCellValue("상품명");
        cell.setCellStyle(headStyle);
        cell = row.createCell(7);
        cell.setCellValue("상품코드");
        cell.setCellStyle(headStyle);
        cell = row.createCell(8);
        cell.setCellValue("슬롯번호");
        cell.setCellStyle(headStyle);
        cell = row.createCell(9);
        cell.setCellValue("건수");
        cell.setCellStyle(headStyle);
        cell = row.createCell(10);
        cell.setCellValue("금액");
        cell.setCellStyle(headStyle);
        cell = row.createCell(11);
        cell.setCellValue("투출여부");
        cell.setCellStyle(headStyle);

        // Body
        if(!result.isEmpty()) {
            for (SalesProduct sp : result) {
                if (!pre_date.equals("") && !sp.getTransactionDate().equals(pre_date)) {
                    row = sheet.createRow(rowNum++);
                    cell = row.createCell(0);
                    cell.setCellValue(">> "+pre_date+" 소계");
                    cell.setCellStyle(subTotalStyle);
                    cell = row.createCell(1);cell.setCellStyle(subTotalStyle);
                    cell = row.createCell(2);cell.setCellStyle(subTotalStyle);
                    cell = row.createCell(3);cell.setCellStyle(subTotalStyle);
                    cell = row.createCell(4);cell.setCellStyle(subTotalStyle);
                    cell = row.createCell(5);cell.setCellStyle(subTotalStyle);
                    cell = row.createCell(6);cell.setCellStyle(subTotalStyle);
                    cell = row.createCell(7);cell.setCellStyle(subTotalStyle);
                    cell = row.createCell(8);cell.setCellStyle(subTotalStyle);
                    cell = row.createCell(9);
                    //cell.setCellValue(decFormat.format(count));
                    cell.setCellValue(count);
                    cell.setCellStyle(subTotalStyle);
                    cell = row.createCell(10);
                    //cell.setCellValue(decFormat.format(amount));
                    cell.setCellValue(amount);
                    cell.setCellStyle(subTotalStyle);
                    cell = row.createCell(11);cell.setCellStyle(subTotalStyle);
                    count = 0;
                    amount = 0;
                }
                pre_date = sp.getTransactionDate();
                if(!sp.getShipResult().equals("미투출")){
                    count = count + sp.getCount();
                    amount = amount + sp.getProductPrice();
                    total_count = total_count + sp.getCount();
                    total_amount = total_amount + sp.getProductPrice();
                }
                row = sheet.createRow(rowNum++);
                cell = row.createCell(0);
                cell.setCellStyle(defaultStyle);
                cell.setCellValue(sp.getOrganizationName());
                cell = row.createCell(1);
                cell.setCellStyle(defaultStyle);
                cell.setCellValue(sp.getPlace());
                cell = row.createCell(2);
                cell.setCellStyle(defaultStyle);
                cell.setCellValue(sp.getVmId());
                cell = row.createCell(3);
                cell.setCellStyle(defaultStyle);
                cell.setCellValue(sp.getTerminalId());
                cell = row.createCell(4);
                cell.setCellStyle(defaultStyle);
                cell.setCellValue(sp.getTransactionDate() + " " + sp.getTransactionTime());
                cell = row.createCell(5);
                cell.setCellStyle(defaultStyle);
                cell.setCellValue(sp.getTransactionNo());
                cell = row.createCell(6);
                cell.setCellStyle(defaultStyle);
                cell.setCellValue(sp.getProductName());
                cell = row.createCell(7);
                cell.setCellStyle(defaultStyle);
                cell.setCellValue(sp.getProductCode());
                cell = row.createCell(8);
                cell.setCellStyle(defaultStyle);
                cell.setCellValue(sp.getSlotNo());
                cell = row.createCell(9);
                cell.setCellStyle(numberStyle);
                //cell.setCellValue(decFormat.format(sp.getCount()));
                cell.setCellValue(sp.getCount());
                cell = row.createCell(10);
                cell.setCellStyle(numberStyle);
                //cell.setCellValue(decFormat.format(sp.getProductPrice()));
                cell.setCellValue(sp.getProductPrice());
                cell = row.createCell(11);
                cell.setCellValue(sp.getShipResult());
                if(sp.getShipResult().equals("미투출")){
                   cell.setCellStyle(shipResultFStyle);
                }else cell.setCellStyle(defaultStyle);

            }
            row = sheet.createRow(rowNum++);
            cell = row.createCell(0);
            cell.setCellValue(">> "+pre_date+" 소계");
            cell.setCellStyle(subTotalStyle);
            cell = row.createCell(1);cell.setCellStyle(subTotalStyle);
            cell = row.createCell(2);cell.setCellStyle(subTotalStyle);
            cell = row.createCell(3);cell.setCellStyle(subTotalStyle);
            cell = row.createCell(4);cell.setCellStyle(subTotalStyle);
            cell = row.createCell(5);cell.setCellStyle(subTotalStyle);
            cell = row.createCell(6);cell.setCellStyle(subTotalStyle);
            cell = row.createCell(7);cell.setCellStyle(subTotalStyle);
            cell = row.createCell(8);cell.setCellStyle(subTotalStyle);
            cell = row.createCell(9);
            //cell.setCellValue(decFormat.format(count));
            cell.setCellValue(count);
            cell.setCellStyle(subTotalStyle);
            cell = row.createCell(10);
            //cell.setCellValue(decFormat.format(amount));
            cell.setCellValue(amount);
            cell.setCellStyle(subTotalStyle);
            cell = row.createCell(11);cell.setCellStyle(subTotalStyle);


            row = sheet.createRow(rowNum++);
            cell = row.createCell(0);
            cell.setCellValue(">>> 합계");
            cell.setCellStyle(totalStyle);
            cell = row.createCell(1);cell.setCellStyle(totalStyle);
            cell = row.createCell(2);cell.setCellStyle(totalStyle);
            cell = row.createCell(3);cell.setCellStyle(totalStyle);
            cell = row.createCell(4);cell.setCellStyle(totalStyle);
            cell = row.createCell(5);cell.setCellStyle(totalStyle);
            cell = row.createCell(6);cell.setCellStyle(totalStyle);
            cell = row.createCell(7);cell.setCellStyle(totalStyle);
            cell = row.createCell(8);cell.setCellStyle(totalStyle);
            cell = row.createCell(9);
            //cell.setCellValue(decFormat.format(total_count));
            cell.setCellValue(total_count);
            cell.setCellStyle(totalStyle);
            cell = row.createCell(10);
            //cell.setCellValue(decFormat.format(total_amount));
            cell.setCellValue(total_amount);
            cell.setCellStyle(totalStyle);
            cell = row.createCell(11);cell.setCellStyle(totalStyle);
        }

        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename="+ URLEncoder.encode("멀티자판기")+".xlsx");

        // Excel File Output
        ServletOutputStream outputStream = response.getOutputStream();
        //wb.write(response.getOutputStream());
        wb.write(outputStream);
        outputStream.close();
        return wb;

    }

    public Workbook downExcel_DailySalesData(HttpServletResponse response,Map<String, Object> param) throws IOException {
        List<Sales> result = new ArrayList<>();
        //System.out.println("getExcelSalesData param: "+param);
        if(param.get("searchType")!=null&&param.get("searchType").equals("toProduct")) {
            if (!param.get("productName").equals("")) {
                param.put("productNameList", param.get("productName"));
            }
            result = salesMapper.getDailySalesProductList(param);
        }
        else result = salesMapper.getDailySalesList(param);
        //System.out.println("sa;es일단 학이: "+result);

        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("매출집계");
        Row row = null;
        Cell cell = null;
        int rowNum = 1;

        int count = 0;
        int amount = 0;
        int total_count = 0;
        int total_amount = 0;
        String pre_date = "";
        String pre_productName = "";

        sheet.setColumnWidth(0,9000);
        sheet.setColumnWidth(1,10000);
        sheet.setColumnWidth(2,4000);
        sheet.setColumnWidth(3,4000);
        sheet.setColumnWidth(4,4000);
        sheet.setColumnWidth(5,5000);
        sheet.setColumnWidth(6,7000);

        Font headerFont = wb.createFont();
        headerFont.setBold(true);

        CellStyle headStyle = wb.createCellStyle();
        headStyle.setBorderBottom(BorderStyle.THIN);
        headStyle.setBorderLeft(BorderStyle.THIN);
        headStyle.setBorderRight(BorderStyle.THIN);
        headStyle.setBorderTop(BorderStyle.THIN);
        headStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headStyle.setAlignment(HorizontalAlignment.CENTER);
        headStyle.setFont(headerFont);

        CellStyle subTotalStyle = wb.createCellStyle();
        subTotalStyle.setBorderTop(BorderStyle.THIN);
        subTotalStyle.setBorderBottom(BorderStyle.THIN);
        subTotalStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
        subTotalStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
        subTotalStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        CellStyle subTotalStyle2 = wb.createCellStyle();
        subTotalStyle2.setBorderTop(BorderStyle.THIN);
        subTotalStyle2.setBorderRight(BorderStyle.THIN);
        subTotalStyle2.setBorderBottom(BorderStyle.THIN);
        subTotalStyle2.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
        subTotalStyle2.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        CellStyle totalStyle = wb.createCellStyle();
        totalStyle.setBorderTop(BorderStyle.THIN);
        totalStyle.setBorderBottom(BorderStyle.THIN);
        totalStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
        totalStyle.setFillForegroundColor(IndexedColors.GOLD.getIndex());
        totalStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        totalStyle.setFont(headerFont);

        CellStyle numberStyle = wb.createCellStyle();
        numberStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));

        // Header
        sheet.addMergedRegion(new CellRangeAddress(1,1,1,6));
        sheet.addMergedRegion(new CellRangeAddress(2,2,1,6));
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("페이지명");
        cell.setCellStyle(subTotalStyle2);
        cell = row.createCell(1);
        if(param.get("searchType").equals("toProduct")) {
            cell.setCellValue("상품별 매출집계");
        }else cell.setCellValue("일별 매출집계");

        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("검색조건");
        cell.setCellStyle(subTotalStyle2);
        cell = row.createCell(1);
        if(param.get("searchType").equals("toProduct")) {
            cell.setCellValue("집계기준=거래일&집계기간="+param.get("sDate")+"-"+param.get("eDate")+"&소속="+param.get("organizationName")+"&설치위치="+param.get("place")+"&상품선택="+param.get("productName"));
        }else cell.setCellValue("집계기준=거래일&집계기간="+param.get("sDate")+"-"+param.get("eDate")+"&소속="+param.get("organizationName")+"&설치위치="+param.get("place")+"");


        rowNum++;
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        if(param.get("searchType").equals("toProduct")) {
            cell.setCellValue("상품명(상품코드)");
        }else cell.setCellValue("날짜");
        cell.setCellStyle(headStyle);
        cell = row.createCell(1);
        cell.setCellValue("설치위치");
        cell.setCellStyle(headStyle);
        cell = row.createCell(2);
        cell.setCellValue("자판기ID");
        cell.setCellStyle(headStyle);
        cell = row.createCell(3);
        cell.setCellValue("단말기ID");
        cell.setCellStyle(headStyle);
        cell = row.createCell(4);
        if(param.get("searchType").equals("toProduct")) {
            cell.setCellValue("건수");
        }else cell.setCellValue("거래건수");
        cell.setCellStyle(headStyle);
        cell = row.createCell(5);
        cell.setCellValue("금액");
        cell.setCellStyle(headStyle);

        // Body
        if(!result.isEmpty()) {
            for (Sales sp : result) {
                if(param.get("searchType").equals("toProduct")) {
                    if (!pre_date.equals("") && !sp.getProductCode().equals(pre_date)) {
                        row = sheet.createRow(rowNum++);
                        cell = row.createCell(0);
                        cell.setCellValue(">> " + pre_productName + "("+ pre_date + ") 소계");
                        cell.setCellStyle(subTotalStyle);
                        cell = row.createCell(1);
                        cell.setCellStyle(subTotalStyle);
                        cell = row.createCell(2);
                        cell.setCellStyle(subTotalStyle);
                        cell = row.createCell(3);
                        cell.setCellStyle(subTotalStyle);
                        cell = row.createCell(4);
                        cell.setCellValue(count);
                        cell.setCellStyle(subTotalStyle);
                        cell = row.createCell(5);
                        cell.setCellValue(amount);
                        cell.setCellStyle(subTotalStyle);
                        count = 0;
                        amount = 0;
                    }
                    pre_date = sp.getProductCode();
                    pre_productName = sp.getProductName();
                }else{
                    if (!pre_date.equals("") && !sp.getTransactionDate().equals(pre_date)) {
                        row = sheet.createRow(rowNum++);
                        cell = row.createCell(0);
                        cell.setCellValue(">> " + pre_date + " 소계");
                        cell.setCellStyle(subTotalStyle);
                        cell = row.createCell(1);
                        cell.setCellStyle(subTotalStyle);
                        cell = row.createCell(2);
                        cell.setCellStyle(subTotalStyle);
                        cell = row.createCell(3);
                        cell.setCellStyle(subTotalStyle);
                        cell = row.createCell(4);
                        cell.setCellValue(count);
                        cell.setCellStyle(subTotalStyle);
                        cell = row.createCell(5);
                        cell.setCellValue(amount);
                        cell.setCellStyle(subTotalStyle);
                        count = 0;
                        amount = 0;
                    }
                    pre_date = sp.getTransactionDate();
                }
                count = count + sp.getItemCount();
                amount = amount + sp.getAmount();
                total_count = total_count + sp.getItemCount();
                total_amount = total_amount + sp.getAmount();

                row = sheet.createRow(rowNum++);
                cell = row.createCell(0);
                if(param.get("searchType").equals("toProduct")) {
                    cell.setCellValue(sp.getProductName()+"("+sp.getProductCode()+")");
                }else cell.setCellValue(sp.getTransactionDate());
                cell = row.createCell(1);
                cell.setCellValue(sp.getPlace());
                cell = row.createCell(2);
                cell.setCellValue(sp.getVmId());
                cell = row.createCell(3);
                cell.setCellValue(sp.getTerminalId());
                cell = row.createCell(4);
                cell.setCellStyle(numberStyle);
                cell.setCellValue(sp.getItemCount());
                cell = row.createCell(5);
                cell.setCellStyle(numberStyle);
                cell.setCellValue(sp.getAmount());

            }
            row = sheet.createRow(rowNum++);
            cell = row.createCell(0);
            if(param.get("searchType").equals("toProduct")) {
                cell.setCellValue(">> " + pre_productName + "("+ pre_date + ") 소계");
            }else cell.setCellValue(">> " + pre_date + " 소계");

            cell.setCellStyle(subTotalStyle);
            cell = row.createCell(1);
            cell.setCellStyle(subTotalStyle);
            cell = row.createCell(2);
            cell.setCellStyle(subTotalStyle);
            cell = row.createCell(3);
            cell.setCellStyle(subTotalStyle);
            cell = row.createCell(4);
            cell.setCellValue(count);
            cell.setCellStyle(subTotalStyle);
            cell = row.createCell(5);
            cell.setCellValue(amount);
            cell.setCellStyle(subTotalStyle);

            row = sheet.createRow(rowNum++);
            cell = row.createCell(0);
            cell.setCellValue(">>> 합계");
            cell.setCellStyle(totalStyle);
            cell = row.createCell(1);cell.setCellStyle(totalStyle);
            cell = row.createCell(2);cell.setCellStyle(totalStyle);
            cell = row.createCell(3);cell.setCellStyle(totalStyle);
            cell = row.createCell(4);cell.setCellValue(total_count);cell.setCellStyle(totalStyle);
            cell = row.createCell(5);cell.setCellValue(total_amount);cell.setCellStyle(totalStyle);
        }

        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename="+ URLEncoder.encode("멀티자판기")+".xlsx");

        // Excel File Output
        ServletOutputStream outputStream = response.getOutputStream();
        wb.write(outputStream);
        outputStream.close();
        return wb;

    }
}
