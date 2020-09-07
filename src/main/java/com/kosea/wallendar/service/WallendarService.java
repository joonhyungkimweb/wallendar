package com.kosea.wallendar.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kosea.wallendar.domain.PkPost;
import com.kosea.wallendar.domain.PostVo;
import com.kosea.wallendar.repository.PostRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WallendarService {

	@NonNull
	private final PostRepository postRepository;
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	

	public PostVo savePost(PostVo post) {
		postRepository.save(post);

		return post;
	}

	public List<PostVo> findAll(String usertag) {

		List<PostVo> posts = new ArrayList<PostVo>();

		postRepository.findByUsertag(usertag).forEach(e -> posts.add(e));

		logger.info(posts.toString());

		return posts;

	}

	public Optional<PostVo> findOne(String usertag, Date postdate) {

		logger.info("ONE");

		PkPost pk = PkPost.builder().usertag(usertag).postdate(postdate).build();

		Optional<PostVo> post = postRepository.findById(pk);

		return post;
	}

	public List<PostVo> SearchByPostDate(Date postdate) {

		List<PostVo> posts = new ArrayList<PostVo>();

		postRepository.findByPostdate(postdate).forEach(e -> posts.add(e));

		return posts;

	}

	public List<PostVo> searchByTag(String tag) {

		List<PostVo> posts = new ArrayList<PostVo>();

		postRepository.findByTagsContaining("#" + tag + "#").forEach(e -> posts.add(e));

		return posts;

	}

	public void updateById(String usertag, Date postdate, PostVo post) {

		PkPost pk = PkPost.builder().usertag(usertag).postdate(postdate).build();

		Optional<PostVo> e = postRepository.findById(pk);

		if (e.isPresent()) {
			if (post.getPic() == null) {
				post.setPic(e.get().getPic());
			}
			postRepository.save(post);
		}
	}

	public void deletePost(String usertag, Date postdate) {
		PkPost pk = PkPost.builder().usertag(usertag).postdate(postdate).build();
		postRepository.deleteById(pk);
	}

}
