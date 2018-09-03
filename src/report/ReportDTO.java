package report;

import java.util.Date;

public class ReportDTO {
	private int rno;
	private String reporter;
	private int targetBno;
	private int reportType;
	private Date reportDate;
	private String isCheck;
	
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getReporter() {
		return reporter;
	}
	public void setReporter(String reporter) {
		this.reporter = reporter;
	}
	public int getTargetBno() {
		return targetBno;
	}
	public void setTargetBno(int targetBno) {
		this.targetBno = targetBno;
	}
	
	public int getReportType() {
		return reportType;
	}
	public void setReportType(int reportType) {
		this.reportType = reportType;
	}
	public Date getReportDate() {
		return reportDate;
	}
	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}
	public String getIsCheck() {
		return isCheck;
	}
	public void setIsCheck(String isCheck) {
		this.isCheck = isCheck;
	}
}
