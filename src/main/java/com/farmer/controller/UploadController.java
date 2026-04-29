package com.farmer.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

@Controller
@RequestMapping("/upload")
public class UploadController {

    private static final Set<String> ALLOWED_SUFFIX = new HashSet<String>(
            Arrays.asList(".jpg", ".jpeg", ".png", ".gif", ".webp", ".bmp")
    );

    @PostMapping("/image")
    @ResponseBody
    public Map<String, Object> uploadImage(MultipartFile file, HttpServletRequest request) throws IOException {
        Map<String, Object> result = new HashMap<String, Object>();
        if (file == null || file.isEmpty()) {
            result.put("success", false);
            result.put("message", "请选择图片文件");
            return result;
        }

        if (file.getSize() > 10 * 1024 * 1024) {
            result.put("success", false);
            result.put("message", "图片大小不能超过 10MB");
            return result;
        }

        String originalFilename = file.getOriginalFilename();
        String suffix = ".jpg";
        if (originalFilename != null && originalFilename.lastIndexOf(".") > -1) {
            suffix = originalFilename.substring(originalFilename.lastIndexOf(".")).toLowerCase();
        }

        if (!ALLOWED_SUFFIX.contains(suffix)) {
            result.put("success", false);
            result.put("message", "仅支持 jpg、jpeg、png、gif、webp、bmp 格式图片");
            return result;
        }

        String folder = "static/upload/" + new SimpleDateFormat("yyyyMMdd").format(new Date());
        String realPath = request.getServletContext().getRealPath("/") + File.separator + folder.replace("/", File.separator);
        File dir = new File(realPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String fileName = UUID.randomUUID().toString().replace("-", "") + suffix;
        File target = new File(dir, fileName);
        file.transferTo(target);

        result.put("success", true);
        result.put("message", "上传成功");
        result.put("path", request.getContextPath() + "/" + folder + "/" + fileName);
        result.put("originalName", originalFilename);
        return result;
    }
}
