package com.practice.board.vo;

import java.util.Date;

public class CommentVO {
	private int com_no;
	private String com_writer;
	private String com_content;	
	private Date com_regdate;
	private int bno;
	
	public CommentVO() {
		// TODO Auto-generated constructor stub
	}
	

	public CommentVO(int com_no, String com_writer, String com_content, Date com_regdate, int bno) {
		super();
		this.com_no = com_no;
		this.com_writer = com_writer;
		this.com_content = com_content;
		this.com_regdate = com_regdate;
		this.bno = bno;
	}




	public int getCom_no() {
		return com_no;
	}
	public void setCom_no(int com_no) {
		this.com_no = com_no;
	}
	public String getCom_writer() {
		return com_writer;
	}
	public void setCom_writer(String com_writer) {
		this.com_writer = com_writer;
	}
	public String getCom_content() {
		return com_content;
	}
	public void setCom_content(String com_content) {
		this.com_content = com_content;
	}
	public Date getCom_regdate() {
		return com_regdate;
	}
	public void setCom_regdate(Date com_regdate) {
		this.com_regdate = com_regdate;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	
	
}
