<template>
    <div class="main-container">
        <div
            ref="editorContainerElement"
            class="editor-container editor-container_classic-editor"
        >
            <div class="editor-container__editor">
                <div ref="editorElement">
                    <ckeditor
                        v-if="editor && config"
                        v-model="editorData"
                        :editor="editor"
                        :config="config"
                        placeholder="Nhập nội dung"
                    />
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { computed, ref, onMounted, watchEffect, onBeforeUpdate } from 'vue';
import { Ckeditor } from '@ckeditor/ckeditor5-vue';
import { watch } from 'vue';

import {
    ClassicEditor,
    Autoformat,
    AutoImage,
    Autosave,
    BlockQuote,
    Bold,
    CKBox,
    CKBoxImageEdit,
    CloudServices,
    Essentials,
    Heading,
    ImageBlock,
    ImageCaption,
    ImageInline,
    ImageInsert,
    ImageInsertViaUrl,
    ImageResize,
    ImageStyle,
    ImageTextAlternative,
    ImageToolbar,
    ImageUpload,
    Indent,
    IndentBlock,
    Italic,
    Link,
    LinkImage,
    List,
    ListProperties,
    MediaEmbed,
    Paragraph,
    PasteFromOffice,
    PictureEditing,
    Table,
    TableCaption,
    TableCellProperties,
    TableColumnResize,
    TableProperties,
    TableToolbar,
    TextTransformation,
    TodoList,
    Underline
} from 'ckeditor5';

import 'ckeditor5/ckeditor5.css';

const LICENSE_KEY = import.meta.env.VITE_CKEDITOR_LICENSE_KEY;
const CLOUD_SERVICES_TOKEN_URL = import.meta.env.VITE_CLOUD_SERVICES_TOKEN_URL;

const isLayoutReady = ref(false);

const editor = ClassicEditor;

const props = defineProps({
    data: {
        type: String,
        default: ''
    },
    isEdit: {
        type: Boolean,
        default: false
    }
});

const editorData = ref(props.data);

const emit = defineEmits(['update:modelValue']);

/**
 * The method watch data
 *
 * @returns {Promise<void>}
 */
watchEffect(() => {
    if (props.isEdit && props.data) {
        editorData.value = props.data;
    }
});

let timeout;

/**
 * The method watch data and emit data to parent
 *
 * @returns {Promise<void>}
 */
watch(editorData, (newValue) => {
    clearTimeout(timeout);

    timeout = setTimeout(() => {
        emit('update:modelValue', newValue);
    }, 2000);
});

const config = computed(() => {
    if (!isLayoutReady.value) {
        return null;
    }

    return {
        toolbar: {
            items: [
                'heading',
                '|',
                'bold',
                'italic',
                'underline',
                '|',
                'link',
                'insertImage',
                'mediaEmbed',
                'insertTable',
                'blockQuote',
                '|',
                'bulletedList',
                'numberedList',
                'todoList',
                'outdent',
                'indent'
            ],
            shouldNotGroupWhenFull: false
        },
        plugins: [
            Autoformat,
            AutoImage,
            Autosave,
            BlockQuote,
            Bold,
            CKBox,
            CKBoxImageEdit,
            CloudServices,
            Essentials,
            Heading,
            ImageBlock,
            ImageCaption,
            ImageInline,
            ImageInsert,
            ImageInsertViaUrl,
            ImageResize,
            ImageStyle,
            ImageTextAlternative,
            ImageToolbar,
            ImageUpload,
            Indent,
            IndentBlock,
            Italic,
            Link,
            LinkImage,
            List,
            ListProperties,
            MediaEmbed,
            Paragraph,
            PasteFromOffice,
            PictureEditing,
            Table,
            TableCaption,
            TableCellProperties,
            TableColumnResize,
            TableProperties,
            TableToolbar,
            TextTransformation,
            TodoList,
            Underline
        ],
        cloudServices: {
            tokenUrl: CLOUD_SERVICES_TOKEN_URL
        },
        heading: {
            options: [
                {
                    model: 'paragraph',
                    title: 'Paragraph',
                    class: 'ck-heading_paragraph'
                },
                {
                    model: 'heading1',
                    view: 'h1',
                    title: 'Heading 1',
                    class: 'ck-heading_heading1'
                },
                {
                    model: 'heading2',
                    view: 'h2',
                    title: 'Heading 2',
                    class: 'ck-heading_heading2'
                },
                {
                    model: 'heading3',
                    view: 'h3',
                    title: 'Heading 3',
                    class: 'ck-heading_heading3'
                },
                {
                    model: 'heading4',
                    view: 'h4',
                    title: 'Heading 4',
                    class: 'ck-heading_heading4'
                },
                {
                    model: 'heading5',
                    view: 'h5',
                    title: 'Heading 5',
                    class: 'ck-heading_heading5'
                },
                {
                    model: 'heading6',
                    view: 'h6',
                    title: 'Heading 6',
                    class: 'ck-heading_heading6'
                }
            ]
        },
        image: {
            toolbar: [
                'toggleImageCaption',
                'imageTextAlternative',
                '|',
                'imageStyle:inline',
                'imageStyle:wrapText',
                'imageStyle:breakText',
                '|',
                'resizeImage',
                '|',
                'ckboxImageEdit'
            ]
        },
        initialData: '',
        licenseKey: LICENSE_KEY,
        link: {
            addTargetToExternalLinks: true,
            defaultProtocol: 'https://',
            decorators: {
                toggleDownloadable: {
                    mode: 'manual',
                    label: 'Downloadable',
                    attributes: {
                        download: 'file'
                    }
                }
            }
        },
        list: {
            properties: {
                styles: true,
                startIndex: true,
                reversed: true
            }
        },
        placeholder: 'Nhập nội dung mô tả',
        table: {
            contentToolbar: [
                'tableColumn',
                'tableRow',
                'mergeTableCells',
                'tableProperties',
                'tableCellProperties'
            ]
        }
    };
});

onMounted(() => {
    isLayoutReady.value = true;
});

watchEffect(() => {
    if (config.value) {
        configUpdateAlert(config.value);
    }
});

/**
 * This function exists to remind you to update the config needed for premium features.
 * The function can be safely removed. Make sure to also remove call to this function when doing so.
 */
function configUpdateAlert(config) {
    if (configUpdateAlert.configUpdateAlertShown) {
        return;
    }

    const isModifiedByUser = (currentValue, forbiddenValue) => {
        if (currentValue === forbiddenValue) {
            return false;
        }

        if (currentValue === undefined) {
            return false;
        }

        return true;
    };

    const valuesToUpdate = [];

    configUpdateAlert.configUpdateAlertShown = true;

    if (
        !isModifiedByUser(
            config.cloudServices?.tokenUrl,
            '<YOUR_CLOUD_SERVICES_TOKEN_URL>'
        )
    ) {
        valuesToUpdate.push('CLOUD_SERVICES_TOKEN_URL');
    }

    if (valuesToUpdate.length) {
        window.alert(
            [
                'Please update the following values in your editor config',
                'to receive full access to Premium Features:',
                '',
                ...valuesToUpdate.map((value) => ` - ${value}`)
            ].join('\n')
        );
    }
}
</script>

<style lang="scss" scoped>
</style>
