package com.practice.file.controller;


import java.io.File;
import java.io.OutputStream;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.coobird.thumbnailator.Thumbnails;

@Controller
public class FileDownloadController {
	private static final String BOARD_IMAGE_REPO="C:\\spring\\image_repo";
	
	@RequestMapping(value="/download")
	protected void download(@RequestParam("fileName") String fileName, @RequestParam("bno") int bno, HttpServletResponse response) throws Exception {
		OutputStream out=response.getOutputStream();
		String filePath=BOARD_IMAGE_REPO+"\\"+bno+"\\"+fileName;
		File image=new File(filePath);
		
		//확장자 제외한 원본 이미지 파일 이름 가져오기
		int lastIndex=fileName.lastIndexOf(".");
		String imageFileName=fileName.substring(0, lastIndex);
		
		//원본이미지 파일 이름과 같은 이름의 썸네일 파일에 대한 File 객체 생성
		File thumbnail=new File(BOARD_IMAGE_REPO+"\\"+"thumbnail"+"\\"+imageFileName+".png");
		
		if(image.exists()) {
			Thumbnails.of(image).size(200, 200).outputFormat("png").toOutputStream(out);
		}else {
			return;
		}
		
		//썸네일 파일 브라우저로 전송
	
		byte[] buffer=new byte[1024*8];
		out.write(buffer);

		out.close();
	}
}
