package com.practice.board.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.practice.board.dao.BoardDAO;
import com.practice.board.service.BoardService;
import com.practice.board.vo.BoardVO;
import com.practice.board.vo.ImageVO;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	private static final String BOARD_IMAGE_REPO = "C:\\spring\\image_repo";
	@Autowired
	BoardService service;
	@Autowired
	BoardVO boardVO;

	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String boardWrite() {
		//log.info("게시판 등록페이지");
		return "board/write";
	}

	@RequestMapping(value = "/write.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView boardWriteDo(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {

		multipartRequest.setCharacterEncoding("UTF-8");

		Map<String, Object> boardMap = new HashMap<String, Object>();

		// hits와 parentNo 초기값 설정
		boardMap.put("hits", 0);
		boardMap.put("parentNo", 0);

		// 글쓰기에서 전송된 글 정보를 Map에 key/value로 저장
		Enumeration enu = multipartRequest.getParameterNames();

		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			Object value = multipartRequest.getParameter(name);
			boardMap.put(name, value);
		}

		// 파일 업로드 후 반환된 파일 이름이 저장되는 fileList를 다시 map에 저장
		List<String> fileList = upload(multipartRequest);
		List<ImageVO> imageFileList = new ArrayList<ImageVO>();

		if (fileList != null && fileList.size() != 0) {
			for (String fileName : fileList) {
				ImageVO imageVO = new ImageVO();
				imageVO.setFileName(fileName);
				imageFileList.add(imageVO);
			}
			boardMap.put("imageFileList", imageFileList);
		}

		try {
			int bno = service.add(boardMap);
			if (imageFileList != null && imageFileList.size() != 0) {
				for (ImageVO imageVO : imageFileList) {
					String imageFileName = imageVO.getFileName();
					File srcFile = new File(BOARD_IMAGE_REPO + "\\" + imageFileName);
					File destDir = new File(BOARD_IMAGE_REPO + "\\" + bno);
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}
		} catch (Exception e) {
			if (imageFileList != null && imageFileList.size() != 0) {
				for (ImageVO imageVO : imageFileList) {
					String imageFileName = imageVO.getFileName();
					File srcFile = new File(BOARD_IMAGE_REPO + "\\" + imageFileName);
					srcFile.delete();
				}
			}
		}
		return new ModelAndView("redirect:/board/list.do");
	}

	private List<String> upload(MultipartHttpServletRequest multipartRequest) throws Exception {

		List<String> fileList = new ArrayList<String>();

		// 첨부된 파일 이름을 가져옴
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName = mFile.getOriginalFilename();
			fileList.add(originalFileName);

			File file = new File(BOARD_IMAGE_REPO + "\\" + fileName);

			if (mFile.getSize() != 0) {
				if (!file.exists()) { // 경로에 파일이 존재하지 않으면
					if (file.getParentFile().mkdirs()) { // 경로에 해당하는 디렉토리를 만들고
						file.createNewFile();// 파일 생성
					}
					mFile.transferTo(new File(BOARD_IMAGE_REPO + "\\" + originalFileName));
				}
			}
		}
		return fileList;
	}

	@RequestMapping(value = "/reply")
	public ModelAndView boardReply(@RequestParam("parentNo") int parentNo, @RequestParam("section") int section,
			@RequestParam("pageNum") int pageNum) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/reply");

		mav.addObject("parentNo", parentNo);
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);

		return mav;
	}

	@RequestMapping(value = "/reply.do", method = RequestMethod.POST)
	public String replyWriteDo(@RequestParam("section") int section, @RequestParam("pageNum") int pageNum,
			BoardVO boardVO, Model model) throws Exception {
		System.out.println("page: " + section + " , " + pageNum);
		service.addReply(boardVO);
		model.addAttribute("section", section);
		model.addAttribute("pageNum", pageNum);

		return "redirect:/board/list.do?&section=" + section + "&pageNum=" + pageNum;

	}

	@RequestMapping(value = "/list.do")
	public ModelAndView boardListView(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("/board/list");

		String _section = request.getParameter("section");
		String _pageNum = request.getParameter("pageNum");

		// 초기값 설정
		int section = Integer.parseInt(((_section == null) ? "1" : _section));
		int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));

		Map<String, Object> paging = new HashMap<>();
		paging.put("section", section);
		paging.put("pageNum", pageNum);

		// 공지사항 제외한 게시물 총 개수 출력
		int total = service.boardCount();

		// 공지사항, 일반게시물 출력
		List<BoardVO> notice = service.selectNoticeList();
		List<BoardVO> list = service.listBoard(paging);

		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		mav.addObject("totalBoard", total);
		mav.addObject("notice", notice);
		mav.addObject("list", list);

		return mav;
	}

	@RequestMapping(value = "/read.do")
	public String boardDetail(@RequestParam("bno") int bno, @RequestParam("section") int section,
			@RequestParam("pageNum") int pageNum, HttpSession session, Model model) throws Exception {

		// Set에 readBno 값 저장
		Set<Integer> readBno = (Set<Integer>) session.getAttribute("readBno");
		System.out.println("readBno: " + readBno);

		// 초기 readBno null일 때 처리하는 로직
		if (readBno == null) {
			readBno = new HashSet<>();
			session.setAttribute("readBno", readBno);
		}

		// readBno에 들어있지 않은 값일 때 처리하는 로직-최조 클릭 게시물 조회수 +1 증가 후 readBno에 해당 bno 저장
		if (!readBno.contains(bno)) {
			service.updateHits(bno);
			readBno.add(bno);
		}

		// readBno에 저장된 값이랑 bno 같을 경우 아래 로직만 수행
		Map<String, Object> boardMap = service.boardDetail(bno);
		model.addAttribute("boardMap", boardMap);
		model.addAttribute("section", section);
		model.addAttribute("pageNum", pageNum);
		return "board/read";
	}

	@RequestMapping(value = "/update.do", method = RequestMethod.POST)
	public String boardUpdate(@RequestParam("section") int section, @RequestParam("pageNum") int pageNum,
			BoardVO boardVO, MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		System.out.println("업데이트 page: " + section + " , " + pageNum);
		multipartRequest.setCharacterEncoding("UTF-8");
		Map<String, Object> imageMap = new HashMap<String, Object>();

		// 업로드 된 파일 리스트 생성
		List<String> fileList = upload(multipartRequest);
		List<ImageVO> imageFileList = new ArrayList<ImageVO>();

		service.updateBoard(boardVO);
		int bno = boardVO.getBno();
		System.out.println("update bno: " + bno);

		if (fileList != null && fileList.size() != 0) {
			for (int i = 0; i < fileList.size(); i++) {
				String fileName = fileList.get(i);
				if (fileName != null && !fileName.isEmpty()) {
					ImageVO imageVO = new ImageVO();
					imageVO.setFileName(fileName);
					imageFileList.add(imageVO);
					System.out.println("수정 업로드:" + fileName);

					// 이미지마다 해당하는 fileNo 값을 가져와서 imageMap에 저장
					String[] fileNoArray = multipartRequest.getParameterValues("fileNo");
					System.out.println("길이:" + fileNoArray.length + " , " + "내용?" + fileNoArray);
					imageMap.put("fileNo", fileNoArray[i]);
					imageMap.put("fileName", fileName);

					service.updateImage(imageMap);
				}
			}
		}

		try {
			if (fileList != null && fileList.size() != 0) {
				for (ImageVO imageVO : imageFileList) {
					String imageFileName = imageVO.getFileName();
					System.out.println("update fileName: " + imageFileName);
					File srcFile = new File(BOARD_IMAGE_REPO + "\\" + imageFileName);
					File destDir = new File(BOARD_IMAGE_REPO + "\\" + bno);
					FileUtils.moveFileToDirectory(srcFile, destDir, true);

					// 추후 확인해서 작동되게 할것
//						String originalFileName=multipartRequest.getParameter("originalFileName");
//						System.out.println("oldFile: "+originalFileName);
//						File oldFile=new File(BOARD_IMAGE_REPO+"\\"+bno+"\\"+originalFileName);
//						oldFile.delete();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("오류 발생");
		}

		return "redirect:/board/read.do?bno=" + boardVO.getBno() + "&section=" + section + "&pageNum=" + pageNum;
	}

	@RequestMapping(value = "/delete.do")
	public String boardDelete(int bno) throws Exception {
		service.deleteBoard(bno);
		return "redirect:/board/list.do";
	}

}
