import React, { useState } from 'react';
import ReactMarkdown from 'react-markdown';

const MarkdownEditor = () => {
    const [markdown, setMarkdown] = useState('type markdown here');

    const handleMarkdownChange = (event) => {
        setMarkdown(event.target.value);
    };

    return (
        <div>
            <textarea value={markdown} onChange={handleMarkdownChange} />
            <ReactMarkdown>{markdown}</ReactMarkdown>
        </div>
    );
};

export default MarkdownEditor;
const sentence = "take a sentence as input";
const reversedSentence = sentence.split(" ").reverse().join(" ");
const capitalizedSentence = reversedSentence.charAt(0).toUpperCase() + reversedSentence.slice(1);

console.log(capitalizedSentence);