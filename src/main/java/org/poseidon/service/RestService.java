package org.poseidon.service;

import org.poseidon.dao.RestDAO;
import org.poseidon.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RestService extends AbstractService {

	@Autowired
	private RestDAO restDAO;
	
	public int sendEmail() {
		if (util.getSession().getAttribute("mid") != null) {
			// 메일 발송 + key 데이터베이스에 저장
			String email = getEmail((String) util.getSession().getAttribute("mid"));
			String key = util.createKey();

			MemberDTO dto = new MemberDTO();
			dto.setMemail(email);
			dto.setMkey(key);
			dto.setMid((String) util.getSession().getAttribute("mid"));
			restDAO.setKey(dto); //db에 키 저장하기
			//System.out.println(dto.getMkey());
			// util.sendEmail(email, key);
			// System.out.println("key : " + key);
			return 1;
		} else {
			return 0;
		}
	}

	public String getEmail(String email) {
		return restDAO.getEmail(email);
	}
	

	public int idCheck(String id) {
		return restDAO.idCheck(id);
	}
	

}
