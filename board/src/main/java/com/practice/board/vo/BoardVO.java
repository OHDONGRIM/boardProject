package com.practice.board.vo;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Component
public class BoardVO {
	private int lvl;
	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date writeDate;
	private int notice_chk;
	private int hits;
	private int parentNo;
	

	
	public BoardVO() {}
	
	public BoardVO(int lvl, int bno, String title, String content, String writer, Date writeDate, int hits, int notice_chk,
			int parentNo) {
		this.lvl = lvl;
		this.bno = bno;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.writeDate = writeDate;
		this.hits = hits;
		this.parentNo = parentNo;
		this.notice_chk=notice_chk;

	}
	


	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public int getNotice_chk() {
		return notice_chk;
	}
	public void setNotice_chk(int notice_chk) {
		this.notice_chk = notice_chk;
	}
	public int getHits() {
		return hits;
	}
	public void setHits(int hits) {
		this.hits = hits;
	}
	public int getParentNo() {
		return parentNo;
	}
	public void setParentNo(int parentNo) {
		this.parentNo = parentNo;
	}

	public int getLvl() {
		return lvl;
	}

	public void setLvl(int lvl) {
		this.lvl = lvl;
	}




}
