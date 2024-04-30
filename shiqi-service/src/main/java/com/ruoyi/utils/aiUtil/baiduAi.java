package com.ruoyi.utils.aiUtil;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.domain.AsqBooks;
import com.ruoyi.service.IAsqBooksService;
import okhttp3.*;
import okhttp3.RequestBody;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import java.io.*;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * @Author zjh
 * @Date 2024/3/30 15:23
 **/
@RestController
@RequestMapping("/ai")
public class baiduAi {

    @Autowired
    private IAsqBooksService asqBooksService;

    @Value("${AI.apiKey}")
    public String API_KEY;
    @Value("${AI.secretKey}")
    public  String SECRET_KEY;

    static final OkHttpClient HTTP_CLIENT = new OkHttpClient().newBuilder().
            connectTimeout(10, TimeUnit.SECONDS)  // 连接超时时间
            .readTimeout(30, TimeUnit.SECONDS)     // 读取超时时间
            .writeTimeout(10, TimeUnit.SECONDS)    // 写入超时时间
            .build();

    @PostMapping("/sentAi/{message}")
    public AjaxResult sentAi(@PathVariable String message) throws IOException {
        List<AsqBooks> asqBooks = asqBooksService.selectAsqBooksList(new AsqBooks());
        StringBuffer stringBuffer = new StringBuffer();
        for (AsqBooks asqBook : asqBooks) {
            stringBuffer.append("书籍ID" + asqBook.getBookId() + ",书籍名" + asqBook.getBookName() + ";");
        }
        MediaType mediaType = MediaType.parse("application/json");
        // 创建请求体，将message变量插入到JSON字符串中
        String json = String.format(
                "{\"messages\":[{\"role\":\"user\",\"content\":\"%s\"}],\"system\":\" 拾柒助手模型：角色定位：智能阅读推荐客服。技能：查询书籍，推荐合适读物，提供书评。背景：结合自然语言处理技术，成为用户的阅读助手。互动表现：当用户请求推荐书籍时，将以这个模板回答'《书籍名》 http://localhost/cms/main/cmsDetail?pptUrl= + 书籍ID'，方便用户直接了解书籍的详细信息。同时，如果用户想要了解某本书的书评，我也会迅速提供相关的评价和解析。台词风格：亲切自然，尊重用户。与其他角色关系：与其他组件合作，为用户提供阅读服务。书籍列表：%s\",\"disable_search\":false,\"enable_citation\":false}",
                message,stringBuffer // 在这里插入message变量的值
        );

        // 创建请求体
        RequestBody body = RequestBody.create(mediaType, json);
        Request request = new Request.Builder()
                .url("https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/completions_pro?access_token=" + getAccessToken())
                .method("POST", body)
                .addHeader("Content-Type", "application/json")
                .build();
        Response response = HTTP_CLIENT.newCall(request).execute();
        // 解析 JSON 字符串
        JSONObject jsonObject = JSONObject.parseObject(response.body().string());

        // 获取 "result" 字段的值
        String result = jsonObject.getString("result");

        // 输出结果
        System.out.println(result);
        return AjaxResult.success(result);
    }

    /**
     * 从用户的AK，SK生成鉴权签名（Access Token）
     *
     * @return 鉴权签名（Access Token）
     * @throws IOException IO异常
     */
    String getAccessToken() throws IOException {
        MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
        RequestBody body = RequestBody.create(mediaType, "grant_type=client_credentials&client_id=" + API_KEY
                + "&client_secret=" + SECRET_KEY);
        Request request = new Request.Builder()
                .url("https://aip.baidubce.com/oauth/2.0/token")
                .method("POST", body)
                .addHeader("Content-Type", "application/x-www-form-urlencoded")
                .build();
        Response response = HTTP_CLIENT.newCall(request).execute();
        // 解析响应体为字符串
        String responseBody = response.body().string();

        // 使用fastjson将字符串解析为JSONObject
        JSONObject jsonObject = JSON.parseObject(responseBody);

        // 从JSONObject中提取访问令牌
        return jsonObject.getString("access_token");
    }
}
