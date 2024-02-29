package org.poseidon.dao;

import java.util.List;

import org.poseidon.dto.GalleryDTO;
import org.springframework.stereotype.Repository;

@Repository
public class GalleryDAO extends AbstractDAO{
		
	public int galleryInsert(GalleryDTO dto) {
		return sqlSession.insert("gallery.galleryInsert", dto);
	}

	public List<GalleryDTO> galleryList() {
		return sqlSession.selectList("gallery.galleryList");
	}

	public GalleryDTO galleryDetail(int no) {
		return sqlSession.selectOne("galleryDetail", no);
	}
	
}
