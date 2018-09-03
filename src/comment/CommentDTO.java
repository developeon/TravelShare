package comment;

import java.util.Date;

public class CommentDTO {
	private int cno;
	private String writerID;
	private String comment;
	private Date regDate;
	private int bno;
	
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public String getWriterID() {
		return writerID;
	}
	public void setWriterID(String writerID) {
		this.writerID = writerID;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getRegDate() {
		String date = regDate.toString();
		return date.substring(2, date.length()).replaceAll("-", ". ");
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
}
