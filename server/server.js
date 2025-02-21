const express = require('express');
const app = express();
const mongoose = require('mongoose');

// 连接 MongoDB
mongoose.connect('mongodb://localhost:27017/learning-app', {
    useNewUrlParser: true,
    useUnifiedTopology: true
});

const taskSchema = new mongoose.Schema({
    name: String,
    description: String,
    studyTime: Number,
    breakCount: Number
});

const Task = mongoose.model('Task', taskSchema);

app.use(express.json());

// 保存学习任务
app.post('/tasks', async (req, res) => {
    const { name, description, studyTime, breakCount } = req.body;
    const task = new Task({ name, description, studyTime, breakCount });
    await task.save();
    res.status(201).send(task);
});

// 获取学习任务历史记录
app.get('/tasks', async (req, res) => {
    const tasks = await Task.find();
    res.send(tasks);
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});