package board;

import java.util.Date;

public class BoardDTO {
	private int bno;
	private String writerID;
	private Date regDate;
	private String content;
	private String fileName1;
	private String fileName2;
	private String fileName3;
	private String fileName4;
	private String fileName5;
	private String del_chk;
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getWriterID() {
		return writerID;
	}
	public void setWriterID(String writerID) {
		this.writerID = writerID;
	}
	public String getRegDate() {
		String date = regDate.toString();
		return date.substring(2, date.length()).replaceAll("-", ". ");
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFileName1() {
		return fileName1;
	}
	public void setFileName1(String fileName1) {
		this.fileName1 = fileName1;
	}
	public String getFileName2() {
		return fileName2;
	}
	public void setFileName2(String fileName2) {
		this.fileName2 = fileName2;
	}
	public String getFileName3() {
		return fileName3;
	}
	public void setFileName3(String fileName3) {
		this.fileName3 = fileName3;
	}
	public String getFileName4() {
		return fileName4;
	}
	public void setFileName4(String fileName4) {
		this.fileName4 = fileName4;
	}
	public String getFileName5() {
		return fileName5;
	}
	public void setFileName5(String fileName5) {
		this.fileName5 = fileName5;
	}
	public String getDel_chk() {
		return del_chk;
	}
	public void setDel_chk(String del_chk) {
		this.del_chk = del_chk;
	}
}
