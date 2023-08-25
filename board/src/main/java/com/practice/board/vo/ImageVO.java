package com.practice.board.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class ImageVO {
	private int fileNo;
	private String fileName;
	private Date regDate;
	private int bno;
	
	public ImageVO() {}
	
	public ImageVO(String fileName, int bno) {
		this.fileName = fileName;
		this.bno = bno;
	}
	
	public ImageVO(int fileNo, String fileName, Date regDate, int bno) {
		super();
		this.fileNo = fileNo;
		this.fileName = fileName;
		this.regDate = regDate;
		this.bno = bno;
	}
	public int getFileNo() {
		return fileNo;
	}
	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}
	
	public String getFileName() {
		try {
			if(fileName!=null && fileName.length()!=0) {
				this.fileName = URLDecoder.decode(fileName, "UTF-8");
			}
		}catch(UnsupportedEncodingException e){
			e.printStackTrace();
		}
		return fileName;
	}
	
	public 	void setFileName(String fileName) {
		try {
			this.fileName = URLEncoder.encode(fileName, "UTF-8");
		}catch(UnsupportedEncodingException e){
			e.printStackTrace();
		}
	}
	public Date getRegDate() {
		return regDate;
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
