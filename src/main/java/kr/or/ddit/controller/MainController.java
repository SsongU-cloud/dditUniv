package kr.or.ddit.controller;

import java.io.File;
import java.security.Principal;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.MainMapper;
import kr.or.ddit.mapper.UserInfoMapper;
import kr.or.ddit.service.impl.MainService;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StuAttachFileVO;
import kr.or.ddit.vo.StudentStatVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.UserInfoVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/main")
@Slf4j
@Controller
public class MainController {
	
	
	/**
	 * author : 박채연 (아이디/비번 찾기, 마이페이지 수정/조회) 입니다
	 */

	@Autowired
	MainService mainService;
	
	@Autowired
	MainMapper mainmapper;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	String uploadFolder;
	
	@Autowired
	String uploadPath;
	
	@Autowired
	private UserInfoMapper userInfoMapper;
	
	
	
	
	// 학번/사번 찾기
	//{"userName": "박채연","userTel": "010-1234-5678"}
	@ResponseBody
	@PostMapping("/findid")
	public String findId(@RequestBody UserInfoVO uservo) {
		
		String userid = null;
		
		log.info("findid 에 왔다");
		/*
		UserInfoVO(userNo=null, userName=박채연, userPass=null
		, userTel=010-1234-5678, userGubun=null, enabled=0, authorityVOList=null)
		 */
		log.info("findid->uservo : " + uservo);
		
		userid = mainmapper.findid(uservo).getUserNo(); 
		
		log.info("findid->id : " + userid);
		
		//forwarding
		return userid;
	}
	
	// 비번 찾기
	@ResponseBody
	@PostMapping("/findpw")
	public String findpw(@RequestBody Map<String, Object> map) {
		
		String pwd = null;
		
		log.info("findpw 에 왔다");
		
		log.info("map : " , map);
		
		
		int result = mainmapper.findpw(map); 
		
		log.info("result : " + result);
		
		if(result > 0) {			
		
			UUID uuid = UUID.randomUUID();
			// 임시 비밀번호
			pwd = uuid.toString().substring(0, 6);
			String encodedPwd = this.passwordEncoder.encode(pwd);
			
			Map<String, Object> map2 = new HashMap<String, Object>();
			map2.put("pwd", encodedPwd);
			map2.put("stNo", map.get("stNo"));
			
			int result2 = mainmapper.updatepw(map2);
			
			log.info("result 2 : " + result2);
		
		}
		
		// 임시비밀번호
		return pwd;
	}
	
	//Principal : 로그인 후 로그인 한 아이디를 가져올 때 사용함
	// 마이페이지 조회(학생)
	@GetMapping("/mypageDetail")
	public String mypage(Principal principal, Model model) {
		
		if(principal==null) {
			return "redirect:/login";
		}
		
		String name = principal.getName();
		log.info("name : " + name);
		
		//select 해보기(학생 상세 조회)
		StudentVO studentVO = this.mainService.detail(principal);
		log.info("studentVO : " + studentVO);
		
		//select 하기 (학생 사진)
		StuAttachFileVO stuAttachFileVO = this.mainmapper.filedetail(principal.getName());
		log.info("stuAttachFileVO : " + stuAttachFileVO);
		
		model.addAttribute("studentVO", studentVO);
		model.addAttribute("stuAttachFileVO", stuAttachFileVO);
		
		return "user/mypagedetail";
	}
	
	//Principal : 로그인 후 로그인 한 아이디를 가져올 때 사용함
		// 마이페이지 조회(학생)
		@ResponseBody
		@PostMapping("/mypageDetailAjax")
		public UserInfoVO mypageAjax(@RequestBody Map<String,Object> map, Model model, Principal principal) {
//			log.info("mypageAjax->map : " + map);
//			String username = (String)map.get("username");
//			log.info("mypageAjax->username : " + username);
			String stNo = principal.getName();
			
			// 학생 + 교수 
			UserInfoVO userInfoVO = this.userInfoMapper.detail(stNo);
			log.info("mypageAjax->userInfoVO :  " + userInfoVO);
			
			// 학생 상태
//			StudentStatVO studentStatVO = this.mainmapper.mypageStat(stNo);
//			String stat = studentStatVO.getStStat();
//			log.info("학생 상태는 : " + stat);
//			model.addAttribute("stat", stat);
			
			return userInfoVO;
		}
		
		// 마이페이지 학생 상태
		@ResponseBody
		@PostMapping(value="/mypageStatAjax", produces = "application/json;charset=utf-8")
		public String mypageStatAjax(@RequestBody Map<String,Object> map, Principal principal, Model model) {
			log.info("mypageAjax2->map : " + map);
			String userNo = principal.getName();
			
			UserInfoVO uservo = this.mainmapper.usergubun(userNo);
			String stat = "";
			if(uservo.getUserGubun().equals("01")) {
				StudentStatVO studentStatVO = this.mainmapper.mypageStat(userNo);
				stat = studentStatVO.getStStat();
				log.info("학생 상태는 : " + stat);
			} else if(uservo.getUserGubun().equals("02")) {
				ProfessorVO professorVO = this.mainmapper.mypageStatPro(userNo);
				stat = professorVO.getProState();
				log.info("교수 상태는 : " + stat);
			} 
			
			return stat;
		}
		

	
	// 마이페이지 정보 수정 (학생-form)
	@PostMapping("/mypageUpdate")
	public String mypageUpdate(Principal principal, Model model, StudentVO studentVO2, MultipartFile picture, HttpSession session) {
		
		log.info("정보수정에 왔다");
		
		int result = 0;
		String name = principal.getName(); // 회원 아이디
		log.info("name : " + name);
		
		studentVO2.setStNo(name);
		
		log.info("picture orgin name : {}", picture.getOriginalFilename());
		log.info("picture size : {}", picture.getSize());
		
		if(picture.getSize() != 0 && picture.getOriginalFilename() != "") {
			
			File newuploadPath = new File(uploadPath);
			
			
			String fileName = picture.getOriginalFilename();
			long size = picture.getSize();
			
			String contentType = FilenameUtils.getExtension(fileName);
			
			UUID uuid = UUID.randomUUID();
			
			String uploadFileName = uuid.toString() + "_" + fileName;
			
			log.info("fileName : " + fileName);
			log.info("size : " + size);
			log.info("contentType : " + contentType);
			
			File saveFile = new File(newuploadPath + "\\student\\" + uploadFileName);
			log.info("saveFile : " + saveFile);
			
			// 복사 실행
			
			try {
				
				picture.transferTo(saveFile);
				
				// 웹경로
				String webPath = "/" + uploadPath.replace("\\", "/")  + "/" + uploadFileName;
				log.info("webPath : " + webPath);
				
				StuAttachFileVO stuattVO = new StuAttachFileVO();
				stuattVO.setStNo(name);
				stuattVO.setStuFileSize(size);
				stuattVO.setStuGubun("증명사진");
				stuattVO.setStuAttType(contentType);
				stuattVO.setStuOrigin(fileName);
				stuattVO.setStuFileName(uploadFileName);
				stuattVO.setStuFilePath("/upload/student/"+uploadFileName);
				
//				session.setAttribute("chSajin","/upload/student/"+uploadFileName ); // 이렇게하면 그냥 session에 저장됨
//				log.info("사진 session : " + session.getAttribute("chSajin"));
				
				log.info("학생 업로드 사진->stuattVO : " + stuattVO);
				
				// 사진 업로드 후 db 저장 
				
				result = mainmapper.updateAttach(stuattVO);
				
				log.info("imageUpload->result : " + result);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
				// 사진 제외 정보 업로드 후 db에 저장
		
				this.mainmapper.updatepage(studentVO2);
		
//				model.addAttribute("result", result);
				
				
//				return "/main/mypageDetail";
				return "redirect:/main/mypageDetail";
//				return "/login";
		}
	
	// 마이페이지 조회 (교수)
	@GetMapping("/mypageDetailPro")
	public String mypageDetailPro(Principal principal, Model model) {
		
		log.info("교수 마이페이지에 왔다");
		
		String proNo = principal.getName();
		ProfessorVO professorVO = this.mainmapper.detailpro(proNo);
		log.info("professor 정보 조회 : " + professorVO);
		
		ProfessorVO professerVO2 = this.mainmapper.detailProPhoto(proNo);
		log.info("professor 사진 조회 : " + professerVO2);
		
		model.addAttribute("professorVO",professorVO);
		model.addAttribute("professorVO2",professerVO2);
		
		
		return "user/mypagedetailpro";
	}
	
	
	// 마이페이지 수정 (교수)
	@PostMapping("/mypageUpdatePro")
	public String mypageUpdatePro(Principal principal, Model model, 
			MultipartFile picture, ProfessorVO professerVO, HttpSession session) {
		
		log.info("교수 마이페이지 수정에 왔다");
		String proNo = principal.getName();
		professerVO.setProNo(proNo);
		log.info("professerVO : " + professerVO);
		log.info("picture : " + picture);
		
		
		// 교수 정보 수정 1 (연락처)
		int result = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userTel", professerVO.getUserInfoVO().getUserTel());
		map.put("proNo", proNo);
		log.info("map : " + map);
		result += this.mainmapper.updatepro(map);
		log.info("정보 수정 1 result : " + result);
		
		// 교수 정보 수정 2 (그 외)
		result += this.mainmapper.updatepro2(professerVO);
		log.info("정보 수정 2 result : " + result);
		
		// 교수 사진 수정 및 파일 업로드
		
		if(picture.getSize() != 0 && picture.getOriginalFilename() != "") {
			
			File newuploadPath = new File(uploadPath);
			
			
			String fileName = picture.getOriginalFilename();
			long size = picture.getSize();
			
			String contentType = FilenameUtils.getExtension(fileName);
			
			UUID uuid = UUID.randomUUID();
			
			String uploadFileName = uuid.toString() + "_" + fileName;
			
			log.info("fileName : " + fileName);
			log.info("size : " + size);
			log.info("contentType : " + contentType);
			
			File saveFile = new File(newuploadPath + "\\prof\\" + uploadFileName);
			log.info("saveFile : " + saveFile);
			
			// 복사 실행
			
			try {
				
				picture.transferTo(saveFile);
				
				// 웹경로
				String webPath = "/" + uploadPath.replace("\\", "/")  + "/" + uploadFileName;
				log.info("webPath : " + webPath);
				
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("proNo", proNo);
				map2.put("attFileSize", size);
				map2.put("logiFileName", fileName);
				map2.put("phyFileName", uploadFileName);
				map2.put("phySaveRoute", "/upload/prof/"+uploadFileName);
				map2.put("comAttDetSize", size);
				map2.put("comAttDetType", contentType);
				
				session.setAttribute("chSajin","/upload/prof/"+uploadFileName ); // 이렇게하면 그냥 session에 저장됨
				
				log.info("교수 업로드 사진->map2 : " + map2);
				
				
				// 사진 업로드 후 db 저장 
				
				result += mainmapper.updatephoto1(map2);
				log.info("imageUpload 3 ->result : " + result);
				result += mainmapper.updatephoto2(map2);
				log.info("imageUpload 4 ->result : " + result);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		
		return "redirect:/main/mypageDetailPro";
	}
 

	//비밀번호 확인, responsebody : json
	@ResponseBody
	@PostMapping("/pwCheck")
	public String pwCheck(@RequestBody Map<String,Object> map, Principal principal) {
		log.info("pwCheck->map : " + map);
		
		String password = (String)map.get("password");//java
		log.info("pwCheck->password : " + password);
		
		// map를 암호화
		String userNo = principal.getName();
		
		UserInfoVO userInfoVO = mainmapper.pwCheck(userNo);
		log.info("pwCheck->userInfoVO : " + userInfoVO);
		String dbPw = userInfoVO.getUserPass();//asdflsfajdlsfkda
		log.info("pwCheck->dbPw : " + dbPw);
		
		//						   사용자String  db인코딩
		if(passwordEncoder.matches(password, dbPw)){
			return "success";
		}else {
			return "fail";
		}		
	}
	
	// 비밀번호 변경 페이지
	@GetMapping("/passwordChange")
	public String pwUpdatepage() {
		return "user/passwordchange";
	}
	
	
	// 비밀번호 변경 로직 - ajax
	@ResponseBody
	@PostMapping("/passwordChange2")
	public int pwUpdate(@RequestBody Map<String, Object> map, Principal principal) {
		
		log.info("map : " , map);
		String userNo = principal.getName();
		String pass = (String) map.get("newPass");
		String encPass = this.passwordEncoder.encode(pass);
		UserInfoVO userInfoVO = new UserInfoVO();
		userInfoVO.setUserNo(userNo);
		userInfoVO.setUserPass(encPass);
		int result = mainmapper.updatepw2(userInfoVO);
		log.info("비밀번호 변경 result : " + result);
		
		return result;
	}
	
	
	


}
